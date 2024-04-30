import 'package:app_mental/Screens/Home/Widgets/body.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:app_mental/classes/SensorConfiguration.dart';
import 'package:app_mental/classes/sensorConfigurationDatabase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sensor_med/sensor_med.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../constants.dart';
import '../../helper/helperfuncions.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userEmail;

  @override
  void initState() {
    getUserEmail();

    super.initState();
  }

  void _handleMessage(RemoteMessage message) {
    Navigator.pushNamed(context, "/${message.data['payload']}");
  }

  getUserEmail() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((value) {
      setState(() {
        userEmail = value;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        SensorConfigurationDatabase.instance
            .getConfiguration(value)
            .then((sensorConfiguration) {
          if (sensorConfiguration == null) {
            SensorConfigurationDatabase.instance.add(SensorConfiguration(
                userEmail: value, accelerometer: 0, gyroscope: 0, location: 0));
          } else if (sensorConfiguration.accelerometer == 1 ||
              sensorConfiguration.gyroscope == 1 ||
              sensorConfiguration.location == 1) {
            final url = dotenv.env['BACKEND_URL']!;
            SensorMed.instance.startSensorsService(
                url: '${url}sendSensorData',
                captureAccelerometer: sensorConfiguration.accelerometer == 1,
                captureSleep: false, //bug
                captureGyroscope: sensorConfiguration.gyroscope == 1,
                captureLocation: sensorConfiguration.location == 1,
                captureScreenState: false, //bug
                captureDataThrottle: const Duration(seconds: 1),
                sendDataInterval: const Duration(seconds: 20),
                email: value);
          } else {
            SensorMed.instance.stopSensorsService();
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
        backgroundColor: kTextColorGreen,
        shadowColor: Color.fromRGBO(1, 1, 1, 0),
      ),
      drawer: AppDrawer(key: Key("drawer")),
      body: Body(),
    );
  }
}
