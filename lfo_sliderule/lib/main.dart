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
  var lfoRate = 32;

  var lfoMultiplier = 1; // 2^0
  var lfoMultiplierPower = 0;

  var bpm = 120;

  var lfoCyclesPerBar = 0;

  Text bpmLabel() => Text('BPM: $bpm');
  Text rateLabel() => Text('Rate: $lfoRate');
  Text multiplierLabel() => Text('Multiplier: ${lfoMultiplier}x');

  List sliderAttributes() => [
        SliderAttribute(bpmLabel(), bpm, bpmMax, bpmMin),
        SliderAttribute(rateLabel(), lfoRate, lfoRateMax, lfoRateMin),
        SliderAttribute(multiplierLabel(), lfoMultiplierPower,
            lfoMultiplierMaxPower, lfoMultiplierMinPower),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: const <Widget>[LabeledSlider(title: 'BPM')],
      )),
    );
  }

  num calculateStepsPerLFOCycle() => 16 * calculateBarsPerLFOCycle();

  num calculateBeatsPerLFOCycle() => calculateStepsPerLFOCycle() / 4;

  num calculateLFOCyclesPerBar() => (lfoRate * lfoMultiplier) / 128;

  num calculateBarsPerLFOCycle() => 1 / calculateLFOCyclesPerBar();

  num calculateSecondsPerBeat() => 60 / bpm;

  num calculateSecondsPerBar() => calculateSecondsPerBeat() * 4;

  num calculateSecondsPerLFOCycle() =>
      calculateSecondsPerBar() * calculateBarsPerLFOCycle();
}

// TODO: Make this accept a function that I can use for setting state when I make the slider
// TODO: why do I get zero 'intellisense' about what this class's attributes are?
// I am guessing that means I should be using a Widget...
class SliderAttribute {
  final Text label;
  final int currentValue;
  final int minValue;
  final int maxValue;

  SliderAttribute(this.label, this.currentValue, this.maxValue, this.minValue);
}

class LabeledSlider extends StatefulWidget {
  const LabeledSlider({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LabeledSlider> createState() => _LabeledSliderState();
}

class _LabeledSliderState extends State<LabeledSlider> {
  // TODO: Figure out the proper way to manage these values
  final minValue = 30;
  final maxValue = 300;

  final label = const Text('placeholder');
  var currentValue = 120;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      label,
      Slider(
          value: currentValue.toDouble(),
          divisions: maxValue - minValue,
          onChanged: (newValue) {
            setState(() {
              currentValue = newValue.round();
            });
          },
          min: minValue.toDouble(),
          max: maxValue.toDouble())
    ]));
  }
}

/*
- This is the old blob of elements being replaced with a marginally better list builder
<Widget>[
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
*/
