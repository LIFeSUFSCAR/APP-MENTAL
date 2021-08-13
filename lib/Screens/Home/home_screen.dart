import 'package:app_mental/Screens/Home/Widgets/body.dart';
import 'package:app_mental/Services/auth.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthMethods authMethods = new AuthMethods();
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("APP Mental"),
        backgroundColor: kTextColorGreen,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, "SignIn", (Route<dynamic> route) => false);
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      body: Body(),
    );
  }
}
