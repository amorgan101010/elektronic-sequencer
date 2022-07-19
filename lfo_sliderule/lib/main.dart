import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

  var lfoMultiplier = 16; // 2^4
  var lfoMultiplierPower = 4;

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
          Text('BPM: $bpm'),
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
          Text('Rate: $lfoRate'),
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
          Text('Multiplier: ${lfoMultiplier}x'),
          const SizedBox(
            height: 10,
          ),
          Slider(
              value: lfoMultiplierPower.toDouble(),
              divisions: lfoMultiplierMaxPower - lfoMultiplierMinPower,
              onChanged: (newLFOMultiplierPower) {
                setState(() {
                  lfoMultiplierPower = newLFOMultiplierPower.toInt();
                  lfoMultiplier = pow(2, lfoMultiplierPower).toInt();
                });
              },
              min: lfoMultiplierMinPower.toDouble(),
              max: lfoMultiplierMaxPower.toDouble()),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Text('LFO Cycles per 16 step bar: ${calculateLFOCyclesPerBar()}'),
          const SizedBox(
            height: 10,
          ),
          Text('Bars per LFO Cycle: ${calculateBarsPerLFOCycle()}'),
          const SizedBox(
            height: 10,
          ),
          Text('Steps per LFO Cycle: ${calculateStepsPerLFOCycle()}'),
          const SizedBox(
            height: 10,
          ),
          Text('Seconds per LFO Cycle: ${calculateSecondsPerLFOCycle()}'),
        ],
      )),
    );
  }

  num calculateStepsPerLFOCycle() => 16 * calculateBarsPerLFOCycle();

  num calculateBeatsPerLFOCycle() => calculateStepsPerLFOCycle() / 4;

  num calculateLFOCyclesPerBar() => (lfoRate * lfoMultiplier) / 128;

  num calculateBarsPerLFOCycle() => 1 / calculateLFOCyclesPerBar();

  num calculateSecondsPerBeat() => 60 / bpm;

  num calculateSecondsPerBar() => calculateSecondsPerBeat() / 4;

  num calculateSecondsPerLFOCycle() =>
      calculateSecondsPerBar() * (1 / calculateBarsPerLFOCycle());
}
