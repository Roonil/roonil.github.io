import 'dart:math' as math;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/markdown_helpers/json_content.dart';

class ViewerImage {
  final String animatedUrl, staticUrl, altText;

  ViewerImage({
    required this.animatedUrl,
    required this.staticUrl,
    required this.altText,
  });
}

class HorizontalImagesViewer extends StatefulWidget {
  const HorizontalImagesViewer({
    super.key,

    required this.viewerImages,
    required this.height,
  });

  final List<ImageJsonContent> viewerImages;
  final double height;

  @override
  State<HorizontalImagesViewer> createState() => _HorizontalImagesViewerState();
}

class _HorizontalImagesViewerState extends State<HorizontalImagesViewer> {
  final CarouselController controller = CarouselController();
  double? initialWidth, initialHeight;

  @override
  void initState() {
    widget.viewerImages[0].getStaticDimensions().then(
      (value) => setState(() {
        initialHeight = value[1];
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth,
        height: math.max((initialHeight ?? 0) + 80, 160),
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 18,
              child: AspectRatio(
                aspectRatio: 1,
                child: CarouselView.weighted(
                  controller: controller,

                  itemSnapping: true,
                  shrinkExtent: 200,
                  onTap: (value) => showDialog(
                    fullscreenDialog: false,
                    useRootNavigator: true,
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(30),
                      ),
                      child: ImageViewerCard(
                        image: ExtendedImage.asset(
                          (widget.viewerImages[value].animatedUrl),
                          enableLoadState: true,
                          clearMemoryCacheWhenDispose: true,

                          loadStateChanged: (state) {
                            return state.wasSynchronouslyLoaded ||
                                    state.frameNumber != null
                                ? state.completedWidget
                                : const Stack(
                                    alignment: Alignment.center,
                                    fit: StackFit.loose,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsGeometry.all(120),
                                        child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ],
                                  );
                          },

                          fit: BoxFit.scaleDown,

                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ),
                  flexWeights: [1, 4, 1],
                  children: widget.viewerImages
                      .map(
                        (image) => FutureBuilder(
                          future: image.getStaticDimensions(),
                          builder: (context, asyncSnapshot) {
                            return Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: ImageViewerCard(
                                    image: Image.asset(
                                      image.staticUrl,
                                      frameBuilder:
                                          (
                                            context,
                                            child,
                                            frame,
                                            wasSynchronouslyLoaded,
                                          ) {
                                            return wasSynchronouslyLoaded ||
                                                    asyncSnapshot.hasData ||
                                                    frame != null
                                                ? child
                                                : const Stack(
                                                    alignment: Alignment.center,
                                                    fit: StackFit.loose,
                                                    children: [
                                                      SizedBox(
                                                        width: 30,
                                                        height: 30,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    ],
                                                  );
                                          },

                                      fit: BoxFit.scaleDown,
                                      cacheHeight: asyncSnapshot.data?[1]
                                          .toInt(),
                                      cacheWidth: asyncSnapshot.data?[0]
                                          .toInt(),
                                      filterQuality: FilterQuality.high,
                                      height: asyncSnapshot.data?[1],
                                      width: asyncSnapshot.data?[0],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentGeometry.center,
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 30,
                                    color:
                                        Theme.brightnessOf(context) ==
                                            Brightness.light
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            widget.viewerImages.length > 1
                ? ImageViewerButtons(
                    width: constraints.maxWidth,
                    controller: controller,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class ImageViewerButtons extends StatefulWidget {
  const ImageViewerButtons({
    super.key,
    required this.width,
    required this.controller,
  });
  final double width;

  final CarouselController controller;
  @override
  State<ImageViewerButtons> createState() => _ImageViewerButtonsState();
}

class _ImageViewerButtonsState extends State<ImageViewerButtons> {
  bool enableButtons = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(40),
        side: BorderSide(
          width: 0.5,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: enableButtons
                    ? () {
                        setState(() {
                          enableButtons = false;
                          widget.controller
                              .animateTo(
                                widget.controller.offset - widget.width / 6.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOutExpo,
                              )
                              .then(
                                (value) => setState(() {
                                  enableButtons = true;
                                }),
                              );
                        });
                      }
                    : null,
                icon: const Icon(Icons.keyboard_arrow_left),
              ),
            ),

            VerticalDivider(
              width: 0.75,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),

            Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: enableButtons
                    ? () {
                        setState(() {
                          enableButtons = false;
                          widget.controller
                              .animateTo(
                                widget.controller.offset + widget.width / 6.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOutExpo,
                              )
                              .then(
                                (value) => setState(() {
                                  enableButtons = true;
                                }),
                              );
                        });
                      }
                    : null,
                icon: const Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageViewerCard extends StatelessWidget {
  const ImageViewerCard({super.key, required this.image});

  final Widget image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(30),
      child: Card(
        elevation: 12,

        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(30),
          side: BorderSide(
            width: 0.5,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        child: Padding(padding: const EdgeInsets.all(8.0), child: image),
      ),
    );
  }
}
