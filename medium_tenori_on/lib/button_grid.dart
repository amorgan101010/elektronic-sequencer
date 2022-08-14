import 'package:flutter/material.dart';
import 'grid_button_basic.dart';

class Grid extends StatelessWidget {
  final int gridSize;

  const Grid({Key? key, required this.gridSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gridSizeObject = GridSize();
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
      width: gridSizeObject.width,
      height: gridSizeObject.height,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 2.0, color: const Color(0xFF3e3e3e))),
      child: buttonGrid,
    );
  }
}
