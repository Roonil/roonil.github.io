# DMA-BUF Export

- `WayVes` can hand its rendered output to another process instead of (or as well as) drawing it in its own Window. This is done with `DMA-BUFs`: the final texture of a `Shader` is exported as a Linux DMA-BUF, and its file descriptor is sent over a Unix socket.
- The receiving process imports the buffer and samples it directly on the GPU, so no pixels get copied through the CPU.
- This lets shells, bars and widgets (for example, ones written in `Quickshell`) embed `WayVes` Visualisers as part of their own UI.

:::warning
The receiver must run on the same GPU as `WayVes`, and the driver must support the `EGL_MESA_image_dma_buf_export` extension.
:::

---

# Rendering Modes

The `rendering-mode` property of a `Shader` decides where its output goes:

| Mode | Description |
| :--- | :--- |
| 0 or `Windowed` | Renders in a normal Window. Default. No DMA-BUFs are exported. |
| 1 or `Detached` | Renders to DMA-BUFs only. The Window is kept at 1×1, so nothing is visible from `WayVes` itself. |
| 2 or `Mixed` | Renders normally to a Window, and also exports DMA-BUFs. |

```yaml
shaders:
  - name: linear
    class-name: waves
    window-width: 1200
    window-height: 112
    rendering-mode: Detached
    rendering-sockets:
      - waves
```

:::info
In `Detached` mode, the size of the exported buffer comes from `window-width` and `window-height`. Change it at runtime with the `-w` and `-h` CLI Arguments, for example `WayVes -c waves -w 800 -h 112`. In `Mixed` mode, the buffer follows the Window's size.
:::

---

# Rendering Sockets

- `rendering-sockets` lists the names of the sockets to export to. Each name creates a socket at `/tmp/WayVes/<name>.sock`.
- When no names are given, a single socket named after the `class-name` is created, i.e. `/tmp/WayVes/<class-name>.sock`.
- Each socket serves one receiver at a time. To show the same `Shader` in several processes, list one socket per receiver.
- Receivers can connect and disconnect at any time. A new receiver can connect once the previous one has disconnected.

---

# Protocol

The sockets are `AF_UNIX` sockets of type `SOCK_SEQPACKET`. `WayVes` sends one message:
- right after a receiver connects,
- whenever the buffer is recreated, such as after a resize, or when the `Shader` is made visible again with `-v`.

Frames themselves are not sent: `WayVes` keeps rendering into the same buffer, so the receiver imports it once and samples it every frame until a new message arrives.

Each message carries the buffer's file descriptor as `SCM_RIGHTS` ancillary data, and a 32-byte payload:

```c
struct DMABufferMessage {
    int32_t  width;        // Buffer width in pixels
    int32_t  height;       // Buffer height in pixels
    int32_t  pixelFormat;  // DRM FourCC format
    int32_t  stride;       // Bytes per row
    int32_t  offset;       // Offset of the first pixel
    uint64_t modifier;     // DRM format modifier (aligned to 8 bytes)
};
```

:::info
Only single-plane buffers are exported. The receiver owns every file descriptor it gets, and should close the previous one when a new message arrives.
:::

For example, reading a message in Python:

```python
import socket
import struct

sock = socket.socket(socket.AF_UNIX, socket.SOCK_SEQPACKET)
sock.connect("/tmp/WayVes/waves.sock")

data, fds, flags, address = socket.recv_fds(sock, 32, 1)
width, height, pixelFormat, stride, offset, modifier = struct.unpack("=5i4xQ", data)
dmabufFd = fds[0]
```

To display it, import the descriptor with `eglCreateImage` using the `EGL_LINUX_DMA_BUF_EXT` target, passing the width, height, format, file descriptor, offset, stride and modifier as the plane 0 attributes, then bind the image to a texture.

---

# Quickshell

An example implementation of DMA-BUF import surface is available at [WayVes Shell](https://github.com/Roonil/WayVes-Shell)

`DMABufSurface` (from `Quickshell.Wayland`) is a QML item that connects to a socket and draws the received buffer:

```qml
import Quickshell.Wayland

DMABufSurface {
    anchors.fill: parent
    fps: 60
    active: visible
    socketPath: "/tmp/WayVes/waves.sock"
    visibilityChangeCommand: "WayVes -c waves -v {{v}}"
    geometryChangeCommand: "WayVes -c waves -w {{w}} -h {{h}}"
}
```

| Property | Description |
| :--- | :--- |
| socketPath | Full path of the socket to read DMA-BUFs from |
| fps | Rate at which the item redraws the buffer |
| active | Whether the Visualiser is needed. Surfaces reading the same socket are counted, so the `Shader` is only hidden once none of them are active |
| visibilityChangeCommand | Command run when the item becomes active or inactive. `{{v}}` is replaced with 1 or 0 |
| geometryChangeCommand | Command run when the item is resized. `{{w}}` and `{{h}}` are replaced with the size in device pixels |

---

# Visibility

- Hiding a `Shader` with `-v 0` stops it from rendering, and with it the exported buffer stops updating.
- A receiver that only shows the Visualiser some of the time should hide the `Shader` while it is not on screen, so `WayVes` does not render frames nobody sees.
- Showing it again with `-v 1` re-sends the buffer to the connected receiver.



<footer>

[Prev](../updating-properties/cli-arguments.md)
[Next](../recommendations/tips.md)

</footer>
