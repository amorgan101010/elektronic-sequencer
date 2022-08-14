import 'dart:math';

import 'package:flutter/material.dart';

import 'grid_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Square Grid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Square Grid'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int gridSize = 4;
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
              crossAxisCount: gridSize,
              children: List.generate(
                pow(gridSize, 2).toInt(),
                (index) {
                  final rowIndex = (index ~/ gridSize);
                  final columnIndex = index % gridSize;
                  return Card(
                    child: GridButton(
                      rowIndex: rowIndex,
                      columnIndex: columnIndex,
                      gridSize: gridSize,
                    ),
                  );
                },
              ))),
    );
  }
}
