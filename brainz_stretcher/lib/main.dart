import 'package:flutter/material.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

// Based on Soundpool example: <https://pub.dev/packages/soundpool/example>
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: BrainzStretcher()));
}

class BrainzStretcher extends StatefulWidget {
  const BrainzStretcher({Key? key}) : super(key: key);

  @override
  BrainzStretcherState createState() => BrainzStretcherState();
}

class BrainzStretcherState extends State<BrainzStretcher> {
  Soundpool? _pool;
  SoundpoolOptions _soundpoolOptions = const SoundpoolOptions();

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _initPool(_soundpoolOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_pool == null) {
      return Material(
        child: Center(
          child: ElevatedButton(
            onPressed: () => _initPool(_soundpoolOptions),
            child: const Text("Init Soundpool"),
          ),
        ),
      );
    } else {
      return SimpleApp(
        pool: _pool!,
        onOptionsChange: _initPool,
      );
    }
  }

  void _initPool(SoundpoolOptions soundpoolOptions) {
    _pool?.dispose();
    setState(() {
      _soundpoolOptions = soundpoolOptions;
      _pool = Soundpool.fromOptions(options: _soundpoolOptions);
    });
  }
}

class SimpleApp extends StatefulWidget {
  final Soundpool pool;
  final ValueSetter<SoundpoolOptions> onOptionsChange;
  const SimpleApp({Key? key, required this.pool, required this.onOptionsChange})
      : super(key: key);

  @override
  SimpleAppState createState() => SimpleAppState();
}

class SimpleAppState extends State<SimpleApp> {
  int? _brainzSoundStreamId;

  Soundpool get _soundpool => widget.pool;

  @override
  void initState() {
    super.initState();

    _loadSounds();
  }

  void _loadSounds() {
    _soundId = _loadSound();
  }

  @override
  void didUpdateWidget(SimpleApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pool != widget.pool) {
      _loadSounds();
    }
  }

  double _rate = 1.0;
  late Future<int> _soundId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: kIsWeb ? 450 : double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('BRAINZ.mp3'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _playSound,
                    child: const Text("Play"),
                  ),
                  // TODO: Fix pause
                  /* const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _pauseSound,
                    child: const Text("Pause"),
                  ), */
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _stopSound,
                    child: const Text("Stop"),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Set rate '),
              Row(children: [
                Expanded(
                  child: Slider.adaptive(
                    min: 0.5,
                    max: 2.0,
                    value: _rate,
                    onChanged: (newRate) {
                      setState(() {
                        _rate = newRate;
                      });
                      _updateBrainzRate();
                    },
                  ),
                ),
                Text(_rate.toStringAsFixed(3)),
              ]),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> _loadSound() async {
    var asset = await rootBundle.load("sounds/BRAINZ.mp3");
    return await _soundpool.load(asset);
  }

  Future<void> _playSound() async {
    var brainzSound = await _soundId;
    _brainzSoundStreamId = await _soundpool.play(
      brainzSound,
      rate: _rate,
    );
  }

// TODO: Figure out why pause can't be resumed and causes exception on stop
/*   Future<void> _pauseSound() async {
    if (_brainzSoundStreamId != null) {
      await _soundpool.pause(_brainzSoundStreamId!);
    }
  } */

  Future<void> _stopSound() async {
    if (_brainzSoundStreamId != null) {
      await _soundpool.stop(_brainzSoundStreamId!);
    }
  }

  Future<void> _updateBrainzRate() async {
    if (_brainzSoundStreamId != null) {
      if (_brainzSoundStreamId! > 0) {
        await _soundpool.setRate(
            streamId: _brainzSoundStreamId!, playbackRate: _rate);
      }
    }
  }
}
