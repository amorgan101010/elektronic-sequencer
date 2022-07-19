import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LFO SlideRule',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'LFO SlideRule'),
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
  final lfoRate = 1;
  final lfoMultiplier = 1;
  var bpm = 120;

  // TODO: Make functions that calculate these values
  final lfoCycleLengthInSteps = 0;
  final lfoCycleLengthInBeats = 0;
  final lfoCycleLengthInSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Slider(
              value: bpm.toDouble(),
              divisions: 4,
              onChanged: (newBpm) {
                setState(() {
                  bpm = newBpm ~/ 1;
                });
              },
              min: 30,
              max: 300);
        },
      )),
    );
  }

  num calculateLFOCycleDurationInSteps() => lfoRate * lfoMultiplier * bpm;

  num calculateLFOCyclesPerBar() => (lfoRate * lfoMultiplier) / 128;
}
