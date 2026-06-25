import 'package:flutter/material.dart';
import 'package:wayves_wiki/helper_functions/rich_text_from_ticks.dart';

class CustomTableRow {
  final String property, description;
  final String? dataType, example;

  CustomTableRow({
    required this.property,

    required this.description,
    required this.dataType,
    required this.example,
  });

  factory CustomTableRow.fromJson(List<String> jsonRow) {
    if (jsonRow.length == 4) {
      return CustomTableRow(
        property: jsonRow[0],
        description: jsonRow[2],
        dataType: jsonRow[1],
        example: jsonRow[3],
      );
    }
    return CustomTableRow(
      property: jsonRow[0],
      description: jsonRow[1],
      dataType: null,
      example: null,
    );
  }
}

class TableViewer extends StatelessWidget {
  final CustomTableRow? tableHeader;
  final List<CustomTableRow> tableRows;
  const TableViewer({
    super.key,
    required this.tableHeader,
    required this.tableRows,
  });

  get tableHasDataTypes => tableRows[0].dataType != null;
  get tableHasExamples => tableRows[0].example != null;

  @override
  Widget build(BuildContext context) {
    final columnWidths = {
      0: const MaxColumnWidth(FlexColumnWidth(2), FixedColumnWidth(250)),
      1: MaxColumnWidth(
        FlexColumnWidth(tableHasDataTypes ? 1 : 5),
        FixedColumnWidth(tableHasDataTypes ? 130 : 330),
      ),
      2: const MaxColumnWidth(FlexColumnWidth(5), FixedColumnWidth(330)),
      3: MaxColumnWidth(
        FlexColumnWidth(tableHasExamples ? 1.5 : 5),
        FixedColumnWidth(tableHasExamples ? 130 : 330),
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
        tableHeader != null
            ? Table(
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
                          child: Text(
                            tableHeader!.property,
                            style: headerStyle,
                          ),
                        ),
                      ),
                      ...(!tableHasDataTypes
                          ? []
                          : [
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border(left: borderSide),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    tableHeader!.dataType!,
                                    style: headerStyle,
                                  ),
                                ),
                              ),
                            ]),

                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(left: borderSide),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            tableHeader!.description,
                            style: headerStyle,
                          ),
                        ),
                      ),
                      ...(!tableHasExamples
                          ? []
                          : [
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border(left: borderSide),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    tableHeader!.example!,
                                    style: headerStyle,
                                  ),
                                ),
                              ),
                            ]),
                    ],
                  ),
                ],
              )
            : const SizedBox(),
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
            children: tableRows
                .map(
                  (CustomTableRow tableRow) => TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          alignment: Alignment.center,

                          child: Text.rich(
                            HelperFunctions.getRichTextFromTicks(
                              text: tableRow.property,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      ...(!tableHasDataTypes
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

                                  child: Text.rich(
                                    HelperFunctions.getRichTextFromTicks(
                                      text: tableRow.dataType!,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
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

                          child: Text.rich(
                            HelperFunctions.getRichTextFromTicks(
                              text: tableRow.description,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                      ...(!tableHasExamples
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

                                  child: Text.rich(
                                    HelperFunctions.getRichTextFromTicks(
                                      text: tableRow.example!,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
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
        width += (tableHasDataTypes ? 130 : 0);
        width += (tableHasExamples ? 130 : 0);

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
