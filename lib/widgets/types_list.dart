import 'package:flutter/material.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';

class TypesList extends StatelessWidget {
  final List<String> parameters, dataDescriptions;
  const TypesList({
    super.key,
    required this.parameters,
    required this.dataDescriptions,
    required this.dataTypes,
    required this.examples,
  });

  final List<String>? dataTypes, examples;

  @override
  Widget build(BuildContext context) {
    final columnWidths = {
      0: const MaxColumnWidth(FlexColumnWidth(2), FixedColumnWidth(250)),
      1: MaxColumnWidth(
        FlexColumnWidth(dataTypes != null ? 1 : 5),
        FixedColumnWidth(dataTypes != null ? 130 : 330),
      ),
      2: const MaxColumnWidth(FlexColumnWidth(5), FixedColumnWidth(330)),
      3: MaxColumnWidth(
        FlexColumnWidth(examples != null ? 1.5 : 5),
        FixedColumnWidth(examples != null ? 130 : 330),
      ),
    };

    final borderSide = BorderSide(
      width: 1,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white,
    );

    final headerStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);

    final tableColumn = Column(
      children: [
        Table(
          columnWidths: columnWidths,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                border: Border.fromBorderSide(borderSide),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              children: [
                TableCell(
                  child: Container(
                    alignment: Alignment.center,

                    padding: const EdgeInsets.all(8.0),
                    child: Text("Property", style: headerStyle),
                  ),
                ),
                ...(dataTypes == null
                    ? []
                    : [
                        TableCell(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(left: borderSide),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Data Type", style: headerStyle),
                          ),
                        ),
                      ]),

                TableCell(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(border: Border(left: borderSide)),
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Description", style: headerStyle),
                  ),
                ),
                ...(examples == null
                    ? []
                    : [
                        TableCell(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(left: borderSide),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Example", style: headerStyle),
                          ),
                        ),
                      ]),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Table(
            columnWidths: columnWidths,
            border: TableBorder(
              verticalInside: borderSide,
              horizontalInside: borderSide,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              left: borderSide,
              right: borderSide,
              top: borderSide,
              bottom: borderSide,
            ),
            children: parameters.indexed
                .map(
                  (parameter) => TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          alignment: Alignment.center,

                          child: RichTextFromTicks(
                            text: parameter.$2,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      ...(dataTypes == null
                          ? []
                          : [
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,

                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),

                                  child: RichTextFromTicks(
                                    text: dataTypes![parameter.$1],
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ]),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),

                          child: RichTextFromTicks(
                            text: dataDescriptions[parameter.$1],
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                      ...(examples == null
                          ? []
                          : [
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,

                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),

                                  child: RichTextFromTicks(
                                    text: examples![parameter.$1],
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ]),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        int width = 580;
        width += (dataTypes != null ? 130 : 0);
        width += (examples != null ? 130 : 0);

        return constraints.biggest.width <= (width)
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: tableColumn,
              )
            : tableColumn;
      },
    );
  }
}
