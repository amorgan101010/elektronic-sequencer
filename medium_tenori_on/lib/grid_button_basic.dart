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
        border: Border.all(width: 2.0, color: const Color(0xFF3e3e3e)),
      ),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  _isSelected ? const Color(0xFFffbdc0) : Colors.white)),
          // todo: restyle
          //color: _isSelected ? Color(0xFFffbdc0) : Colors.white,
          onPressed: _toggleSelected,
          child: const Text("")),
    );
  }

  void _toggleSelected() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }
}
