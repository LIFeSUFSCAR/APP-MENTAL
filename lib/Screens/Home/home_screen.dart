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
  String? userName;

  @override
  void initState() {
    getUserNameAndEmail();
    super.initState();
  }

  void _handleMessage(RemoteMessage message) {
    Navigator.pushNamed(context, "/${message.data['payload']}");
  }

  getUserNameAndEmail() async {
    await HelperFunctions.getUserNameAndEmailInSharedPreference().then((user) {
      setState(() {
        userName = user["name"];
        userEmail = user["email"];
      });
      //getAvatarImageFromDatabase(user["email"]);
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
      body: Body(userName: userName),
    );
  }
}
