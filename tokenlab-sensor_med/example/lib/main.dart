import 'package:example/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sensor_med/sensor_med.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();

  await dotenv.load();
  Hive.init(directory.path);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SensorMed Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'SensorMed Example',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required this.title,
    super.key,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isServiceRunning = false;
  late final String _databaseUrl;
  late final String _apiKey;
  late final Box<String> _userBox;
  String? _userId;
  final uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _databaseUrl = dotenv.env['DATABASE_URL'] ?? '';
    _apiKey = dotenv.env['API_KEY'] ?? '';
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        _isServiceRunning = await SensorMed.instance.isSensorsServiceRunning();
        _userBox = await Hive.openBox<String>('user');
        _userId = _userBox.get('id');
        if (_userId == null) {
          _userId = uuid.v8();
          await _userBox.put('id', _userId ?? '');
        }
        setState(
          () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _isServiceRunning
                    ? 'The background service is running'
                    : 'The background service is not running',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'The user is: $_userId',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_isServiceRunning) {
                      await SensorMed.instance.stopSensorsService();
                      _isServiceRunning = false;
                    } else {
                      try{
                        await SensorMed.instance.startSensorsService(
                          url:
                          '$_databaseUrl/sensorsData/__at_date__/$_userId.json?auth=$_apiKey',
                          showDebug: DebugLevel.verbose,
                          // captureAccelerometer: false,
                          // captureGyroscope: false,
                          // captureLocation: false,
                          // captureScreenState: false,
                          // captureSleep: false,
                        );
                        _isServiceRunning = true;
                      }catch(e) {
                        if(kDebugMode) {
                          print('Error: $e');
                        }

                        if(e is SensorMedException && context.mounted) {
                          if (e is LocationDeniedException) {
                            //show dialog
                            final snackBar = SnackBar(
                              content: const Text('Location permission denied'),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }

                          if (e is LocationServiceDisabledException) {
                            //show dialog
                            final snackBar = SnackBar(
                              content: const Text('Location service disabled'),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }

                          if (e is HealthPermissionDeniedException) {
                            //show dialog
                            final snackBar = SnackBar(
                              content: const Text('Health permission denied'),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          }

                          if(e is InvalidSendDataUrlException) {
                            //show dialog
                            final snackBar = SnackBar(
                              content: const Text('Invalid send data url'),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        }
                      }
                    }

                    setState(
                      () {},
                    );
                  },
                  child: Text(
                    _isServiceRunning
                        ? 'Stop the background service'
                        : 'Start the background service',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(
                    () {
                      _userId = uuid.v8();
                    },
                  );
                  await _userBox.put('id', _userId ?? '');
                },
                child: const Text('Regenerate uuid'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
