import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeSnippetCard extends StatefulWidget {
  const CodeSnippetCard({super.key, required this.textString, this.language});

  final String textString;
  final String? language;
  @override
  State<CodeSnippetCard> createState() => _CodeSnippetCardState();
}

class _CodeSnippetCardState extends State<CodeSnippetCard> {
  bool showClipboard = false;
  final ScrollController controller = ScrollController();

  Text getGLSLTextSpan(Brightness brightness) {
    List<InlineSpan> children = [];

    Color commentsColor = brightness == Brightness.dark
        ? Colors.grey
        : const Color.fromARGB(255, 185, 185, 185);
    Color dataTypesColor = brightness == Brightness.dark
        ? const Color.fromARGB(255, 175, 133, 252)
        : const Color.fromARGB(255, 114, 45, 241);
    Color standardTokenColor = brightness == Brightness.dark
        ? const Color.fromARGB(255, 255, 249, 238)
        : const Color.fromARGB(255, 21, 21, 21);
    Color operatorsColor = brightness == Brightness.dark
        ? const Color.fromARGB(255, 255, 78, 172)
        : const Color.fromARGB(255, 255, 0, 136);
    Color directivesColor = brightness == Brightness.dark
        ? const Color.fromARGB(255, 255, 142, 253)
        : const Color.fromARGB(255, 184, 0, 181);
    Color bracketsColor = brightness == Brightness.dark
        ? Colors.cyanAccent
        : Colors.cyan;
    Color objectColor = brightness == Brightness.dark
        ? const Color.fromARGB(255, 98, 254, 181)
        : const Color.fromARGB(255, 2, 117, 64);
    Color attributeColor = brightness == Brightness.dark
        ? const Color.fromARGB(218, 255, 255, 255)
        : const Color.fromARGB(218, 0, 0, 0);

    for (String line in widget.textString.split('\n')) {
      for (final (int commentIndex, String commentSeparatedWord)
          in line.split('//').indexed) {
        if (commentIndex.isOdd) {
          children.add(
            TextSpan(
              text: "//$commentSeparatedWord",
              style: (widget.language ?? "glsl") == "glsl"
                  ? GoogleFonts.openSans(
                      color: commentsColor,
                      fontWeight: FontWeight.w600,
                    )
                  : GoogleFonts.openSans(
                      color: standardTokenColor,
                      fontWeight: FontWeight.w400,
                    ),
            ),
          );
        } else {
          for (final (int _, String spaceSeparatedWord)
              in commentSeparatedWord.split(' ').indexed) {
            for (final (int bracketIndex, String bracketSeparatedWord)
                in spaceSeparatedWord.split('(').indexed) {
              TextStyle? textStyle = GoogleFonts.openSans(
                color: standardTokenColor,
                fontWeight: FontWeight.w400,
              );

              if (bracketSeparatedWord == "vec2" ||
                  bracketSeparatedWord == "vec3" ||
                  bracketSeparatedWord == "vec4" ||
                  bracketSeparatedWord == "mat2" ||
                  bracketSeparatedWord == "mat3" ||
                  bracketSeparatedWord == "mat4" ||
                  bracketSeparatedWord == "int" ||
                  bracketSeparatedWord == "double" ||
                  bracketSeparatedWord == "float" ||
                  bracketSeparatedWord == "void" ||
                  bracketSeparatedWord == "clone" ||
                  bracketSeparatedWord == "install" ||
                  bracketSeparatedWord == "-S" ||
                  bracketSeparatedWord == "setup" ||
                  bracketSeparatedWord == "configure" ||
                  bracketSeparatedWord == "sampler2D" ||
                  bracketSeparatedWord == "sampler1D" ||
                  bracketSeparatedWord == "image2D" ||
                  bracketSeparatedWord == "uimage2D" ||
                  bracketSeparatedWord == "transform:" ||
                  bracketSeparatedWord == "bool") {
                textStyle = GoogleFonts.openSans(
                  color: dataTypesColor,
                  fontWeight: FontWeight.w600,
                );
              }

              if (bracketSeparatedWord == "*" ||
                  bracketSeparatedWord == "*=" ||
                  bracketSeparatedWord == "+=" ||
                  bracketSeparatedWord == "|" ||
                  bracketSeparatedWord == "-=" ||
                  bracketSeparatedWord == "/=" ||
                  bracketSeparatedWord == ">>" ||
                  bracketSeparatedWord == "=" ||
                  bracketSeparatedWord == "==" ||
                  bracketSeparatedWord == "+" ||
                  bracketSeparatedWord == "-" ||
                  bracketSeparatedWord == "<" ||
                  bracketSeparatedWord == ">" ||
                  bracketSeparatedWord == "/") {
                textStyle = GoogleFonts.openSans(
                  color: operatorsColor,
                  fontWeight: FontWeight.w400,
                );
              }

              if (bracketSeparatedWord == "inout" ||
                  bracketSeparatedWord == "mod" ||
                  bracketSeparatedWord == "in" ||
                  bracketSeparatedWord == "out" ||
                  bracketSeparatedWord == "abs" ||
                  bracketSeparatedWord == "clamp" ||
                  bracketSeparatedWord == "exp" ||
                  bracketSeparatedWord == "step" ||
                  bracketSeparatedWord == "mix" ||
                  bracketSeparatedWord == "sin" ||
                  bracketSeparatedWord == "cos" ||
                  bracketSeparatedWord == "rgb" ||
                  bracketSeparatedWord == "rgba" ||
                  bracketSeparatedWord == "export" ||
                  bracketSeparatedWord == "meson" ||
                  bracketSeparatedWord == "pacman" ||
                  bracketSeparatedWord == "apt" ||
                  bracketSeparatedWord == "texture" ||
                  bracketSeparatedWord == "ldd" ||
                  bracketSeparatedWord == "git" ||
                  bracketSeparatedWord == "echo" ||
                  bracketSeparatedWord == "cd" ||
                  bracketSeparatedWord == "cp" ||
                  bracketSeparatedWord == "mkdir" ||
                  bracketSeparatedWord == "make" ||
                  bracketSeparatedWord == "grep" ||
                  bracketSeparatedWord == "hsv" ||
                  bracketSeparatedWord == "hsva" ||
                  bracketSeparatedWord == "pow" ||
                  bracketSeparatedWord == "uniform" ||
                  bracketSeparatedWord == "#define" ||
                  bracketSeparatedWord == "#expand" ||
                  bracketSeparatedWord == "#include") {
                textStyle = GoogleFonts.openSans(
                  color: directivesColor,
                  fontWeight: FontWeight.w400,
                );
              }

              children.add(
                TextSpan(
                  text: bracketIndex != 0 ? "(" : "",
                  style: GoogleFonts.openSans(color: bracketsColor),
                ),
              );

              if (!line.contains('#include') &&
                  bracketSeparatedWord.contains('.') &&
                  !RegExp(r'\d').hasMatch(bracketSeparatedWord)) {
                List<String> periodSeparatedWords = bracketSeparatedWord.split(
                  '.',
                );

                for (final (int periodIndex, String periodSeparatedWord)
                    in periodSeparatedWords.indexed) {
                  if (periodIndex != periodSeparatedWords.length - 1) {
                    textStyle = GoogleFonts.openSans(
                      color: objectColor,
                      fontWeight: FontWeight.w700,
                    );
                  } else {
                    textStyle = GoogleFonts.openSans(
                      color: attributeColor,
                      fontWeight: FontWeight.bold,
                    );
                  }
                  children.add(TextSpan(text: periodIndex != 0 ? "." : ""));
                  if (periodSeparatedWord.contains(')')) {
                    List<String> lastBracketSeparatedWords = periodSeparatedWord
                        .split(')');

                    for (final (
                          int lastBracketSeparatedWordIndex,
                          String lastBracketSeparatedWord,
                        )
                        in lastBracketSeparatedWords.indexed) {
                      if (lastBracketSeparatedWordIndex != 0) {
                        children.add(
                          TextSpan(
                            text: ')',
                            style: GoogleFonts.openSans(color: bracketsColor),
                          ),
                        );
                      }
                      children.add(
                        TextSpan(
                          text: lastBracketSeparatedWord,
                          style: textStyle,
                        ),
                      );
                    }
                  } else {
                    children.add(
                      TextSpan(text: periodSeparatedWord, style: textStyle),
                    );
                  }
                }
              } else {
                if (bracketSeparatedWord.contains(')')) {
                  List<String> lastBracketSeparatedWords = bracketSeparatedWord
                      .split(')');

                  for (final (
                        int lastBracketSeparatedWordIndex,
                        String lastBracketSeparatedWord,
                      )
                      in lastBracketSeparatedWords.indexed) {
                    if (lastBracketSeparatedWordIndex != 0) {
                      children.add(
                        TextSpan(
                          text: ')',
                          style: GoogleFonts.openSans(color: bracketsColor),
                        ),
                      );
                    }
                    children.add(
                      TextSpan(
                        text: lastBracketSeparatedWord,
                        style: textStyle,
                      ),
                    );
                  }
                } else {
                  children.add(
                    TextSpan(text: bracketSeparatedWord, style: textStyle),
                  );
                }
              }
            }
            children.add(const TextSpan(text: " "));
          }
        }
      }
      children.add(const TextSpan(text: '\n'));
    }
    return Text.rich(TextSpan(text: "", children: children));
  }

  @override
  Widget build(BuildContext context) {
    void showSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Snippet copied to Clipboard"),
          elevation: 3,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    return TapRegion(
      onTapOutside: (event) => showClipboard
          ? setState(() {
              showClipboard = false;
            })
          : null,
      onTapInside: (event) => !showClipboard
          ? setState(() {
              showClipboard = true;
            })
          : null,
      onTapUpInside: (event) => !showClipboard
          ? setState(() {
              showClipboard = true;
            })
          : null,

      child: MouseRegion(
        onEnter: (event) => setState(() {
          showClipboard = true;
        }),
        onExit: (event) => setState(() {
          showClipboard = false;
        }),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Card.outlined(
              margin: const EdgeInsets.symmetric(vertical: 12),
              elevation: 2,
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(255, 24, 24, 24)
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12,
                    ),
                    child: Text(
                      widget.language ?? "glsl",
                      style: GoogleFonts.openSans(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.blueGrey
                            : Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Scrollbar(
                            controller: controller,

                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              controller: controller,
                              scrollDirection: Axis.horizontal,

                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20,
                                  top: 4,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getGLSLTextSpan(
                                      Theme.of(context).brightness,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            showClipboard
                ? Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12, top: 16),
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: widget.textString),
                          ).then((_) => showSnackBar());
                        },
                        iconSize: 24,
                        icon: const Icon(Icons.copy),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
