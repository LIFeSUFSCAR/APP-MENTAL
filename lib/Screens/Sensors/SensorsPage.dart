import 'package:app_mental/classes/sensorConfigurationDatabase.dart';
import 'package:app_mental/helper/helperfuncions.dart';
import 'package:app_mental/helper/util.dart';
import 'package:flutter/material.dart';

import 'package:app_mental/classes/SensorConfiguration.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sensor_med/sensor_med.dart';

import '../../constants.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({Key? key}) : super(key: key);

  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  bool accelerometer = true;
  bool gyroscope = true;
  bool location = true;
  bool showSuccessMessage = false;
  String? userEmail;
  SensorConfiguration? sensorConfiguration = null;

  @override
  void initState() {
    super.initState();
    getSensorConfiguration();
  }

  getSensorConfiguration() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((value) {
      setState(() {
        userEmail = value;
      });

      SensorConfigurationDatabase.instance
          .getConfiguration(value)
          .then((configuration) => {
                if (configuration != null)
                  {
                    sensorConfiguration = configuration,
                    accelerometer = configuration.accelerometer.isOdd,
                    gyroscope = configuration.gyroscope.isOdd,
                    location = configuration.location.isOdd
                  }
              });
    });
  }

  saveSensorConfiguration() {
    SensorConfigurationDatabase.instance.update(SensorConfiguration(
        id: sensorConfiguration?.id,
        userEmail: userEmail!,
        accelerometer: boolToInt(accelerometer),
        gyroscope: boolToInt(gyroscope),
        location: boolToInt(location)));
    final url = dotenv.env['BACKEND_URL']!;
    SensorMed.instance.stopSensorsService();
    if (location || accelerometer || gyroscope) {
      SensorMed.instance.startSensorsService(
          url: '${url}sendSensorData',
          captureAccelerometer: accelerometer,
          captureSleep: false, //bug
          captureGyroscope: gyroscope,
          captureLocation: location,
          captureScreenState: false, //bug
          captureDataThrottle: const Duration(seconds: 1),
          sendDataInterval: const Duration(seconds: 20),
          email: userEmail!);
    }
    setState(() {
      showSuccessMessage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
            backgroundColor: kTextColorGreen,
            shadowColor: Colors.transparent,
            leading: BackButton(
              color: Colors.white,
              onPressed: () => {Navigator.pop(context)},
            ),
            title: FittedBox(child: Text("Configuração sobre os sensores"))),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "O sensor de acelerometro tem a funcionalidade de medir a aceleração do movimento do celular.",
                  textAlign: TextAlign.center,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Sensor acelerometro:"),
                  Switch(
                    value: accelerometer,
                    activeColor: Colors.green,
                    onChanged: (bool value) {
                      setState(() {
                        accelerometer = value;
                        showSuccessMessage = false;
                      });
                    },
                  )
                ]),
                Text(
                  "O sensor giroscópio mede  a mudança de movimento angular do celular, ou seja, o movimento utilizado ao girar o celular.",
                  textAlign: TextAlign.center,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Sensor giroscopio:"),
                  Switch(
                    value: gyroscope,
                    activeColor: Colors.green,
                    onChanged: (bool value) {
                      setState(() {
                        gyroscope = value;
                        showSuccessMessage = false;
                      });
                    },
                  )
                ]),
                Text(
                  "O sensor de localidade mede a posição da pessoa por um GPS.",
                  textAlign: TextAlign.center,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Sensor de localidade:"),
                  Switch(
                    value: location,
                    activeColor: Colors.green,
                    onChanged: (bool value) {
                      setState(() {
                        location = value;
                        showSuccessMessage = false;
                      });
                    },
                  )
                ]),
                ElevatedButton(
                  onPressed: () => saveSensorConfiguration(),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: const Text('Salvar',
                      style: TextStyle(color: Colors.white)),
                ),
                Visibility(
                  child: Text(
                      "A condiguração de sensores foi salva com sucesso!!"),
                  visible: showSuccessMessage,
                )
              ],
            )));
  }
}
