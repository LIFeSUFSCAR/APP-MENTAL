import 'package:app_mental/Screens/Home/Widgets/body.dart';
import 'package:app_mental/Shared/Widgets/AppDrawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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
    // onNotificationOpenedApp();
    // onMessage();
  }

  // Future<void> onNotificationOpenedApp() async {
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();
  //   if (initialMessage != null) {
  //     _handleMessage(initialMessage);
  //   }
  //   FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  // }

  // Future<void> onMessage() async {
  //   FirebaseMessaging.onMessage.listen((message) {
  //     if (message.notification != null) {
  //       final snackBar = SnackBar(
  //         content: Text(message.notification?.title ?? '', maxLines: 2),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     }
  //   });
  // }

  void _handleMessage(RemoteMessage message) {
    Navigator.pushNamed(context, "/${message.data['payload']}");
  }

  getUserEmail() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((value) {
      setState(() {
        userEmail = value;
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
