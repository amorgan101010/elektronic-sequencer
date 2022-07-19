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
        primarySwatch: Colors.blue,
      ),
      home: const LFOSliders(title: 'LFO SlideRule'),
    );
  }
}

class LFOSliders extends StatefulWidget {
  const LFOSliders({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LFOSliders> createState() => _LFOSlidersState();
}

class _LFOSlidersState extends State<LFOSliders> {
  final bpmMin = 30;
  final bpmMax = 300;
  final lfoRateMin = 1;
  final lfoRateMax = 127;

  // These are powers of 2
  final lfoMultiplierMinPower = 0;
  final lfoMultiplierMaxPower = 6; // 2^6=64

  // How do I avoid using vars for all this??
  var lfoRate = 64;
  var lfoMultiplier = 4;
  var bpm = 120;
  var lfoCyclesPerBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          const Text('BPM'),
          const SizedBox(
            height: 10,
          ),
          Slider(
              value: bpm.toDouble(),
              label: '$bpm',
              divisions: bpmMax - bpmMin,
              onChanged: (newBpm) {
                setState(() {
                  bpm = newBpm.round();
                });
              },
              min: bpmMin.toDouble(),
              max: bpmMax.toDouble()),
          const SizedBox(
            height: 10,
          ),
          const Text('Rate'),
          const SizedBox(
            height: 10,
          ),
          Slider(
              value: lfoRate.toDouble(),
              divisions: lfoRateMax - lfoRateMin,
              onChanged: (newLFORate) {
                setState(() {
                  lfoRate = newLFORate ~/ 1;
                });
              },
              min: lfoRateMin.toDouble(),
              max: lfoRateMax.toDouble()),
          const SizedBox(
            height: 10,
          ),
          const Text('Multiplier'),
          const SizedBox(
            height: 10,
          ),
          Slider(
              value: lfoMultiplier.toDouble(),
              divisions: lfoMultiplierMaxPower - lfoMultiplierMinPower,
              onChanged: (newLFOMultiplier) {
                setState(() {
                  lfoMultiplier = newLFOMultiplier ~/ 1;
                });
              },
              min: lfoMultiplierMinPower.toDouble(),
              max: lfoMultiplierMaxPower.toDouble()),
          // TODO: Make this update when sliders move, somehow
          Text(
              'LFO Cycles per 16 step bar: ${calculateLFOCyclesPerBar().toString()}'),
        ],
      )),
    );
  }

  num calculateLFOCycleDurationInSteps() => lfoRate * lfoMultiplier * bpm;

  num calculateLFOCyclesPerBar() => (lfoRate * lfoMultiplier) / 128;
}
