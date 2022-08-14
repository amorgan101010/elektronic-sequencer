import 'dart:math';

import 'package:flutter/material.dart';

import 'grid_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Square Grid',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Square Grid', gridSize: 8),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.gridSize})
      : super(key: key);

  final int gridSize;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: GridView.count(
              shrinkWrap: true,
              padding: const EdgeInsets.all(3),
              crossAxisCount: widget.gridSize,
              children: List.generate(
                pow(widget.gridSize, 2).toInt(),
                (index) {
                  final rowIndex = (index ~/ widget.gridSize);
                  final columnIndex = index % widget.gridSize;
                  return Card(
                    child: GridButton(
                      rowIndex: rowIndex,
                      columnIndex: columnIndex,
                      gridSize: widget.gridSize,
                    ),
                  );
                },
              ))),
    );
  }
}
