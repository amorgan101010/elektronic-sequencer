import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class GridButton extends StatefulWidget {
  final int rowIndex;
  final int columnIndex;
  final int gridSize;
  const GridButton(
      {Key? key,
      required this.rowIndex,
      required this.columnIndex,
      required this.gridSize})
      : super(key: key);

  @override
  GridButtonState createState() => GridButtonState();
}

class GridButtonState extends State<GridButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              _isSelected ? Theme.of(context).primaryColor : Colors.white)),
      onPressed: _toggleSelected,
      child: Text(
          style: TextStyle(
              color:
                  _isSelected ? Colors.white : Theme.of(context).primaryColor,
              fontSize: 12),
          //maxLines: 1,
          ((widget.rowIndex * widget.gridSize) + widget.columnIndex + 1)
              .toString()),
    );
  }

  void _toggleSelected() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }
}
