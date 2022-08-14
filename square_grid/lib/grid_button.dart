import 'package:flutter/material.dart';

class GridButton extends StatefulWidget {
  final int rowIndex;
  final int columnIndex;
  const GridButton(
      {Key? key, required this.rowIndex, required this.columnIndex})
      : super(key: key);

  @override
  GridButtonState createState() => GridButtonState();
}

class GridButtonState extends State<GridButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                _isSelected ? Theme.of(context).primaryColor : Colors.white)),
        onPressed: _toggleSelected,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Text((widget.rowIndex + widget.columnIndex + 1).toString()),
          ),
        ),
      ),
    );
  }

  void _toggleSelected() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }
}
