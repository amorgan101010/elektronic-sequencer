import 'package:flutter/material.dart';
import 'grid_button_basic.dart';

class Grid extends StatelessWidget {
  final int gridSize;

  const Grid({Key? key, required this.gridSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttons = List.generate(
      gridSize,
      (columnIndex) => List.generate(
        gridSize,
        (rowIndex) => GridButton(rowIndex: rowIndex, columnIndex: columnIndex),
      ),
    );

    var buttonGrid = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .map(
            (buttonColumn) => Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttonColumn,
            ),
          )
          .toList(),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: buttonGrid,
    );
  }
}
