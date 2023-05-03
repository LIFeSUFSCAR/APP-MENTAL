import 'package:app_mental/animation/FadeAnimation.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

import '../../Services/userService.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEdittingController =
      new TextEditingController();

  reset() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var snackBar = SnackBar(
        content: new Row(
      children: <Widget>[
        new CircularProgressIndicator(),
        new Text("    Enviando email para recuperar senha!")
      ],
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    UserService()
        .resetPassword(emailTextEdittingController.text)
        .then((response) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      snackBar = SnackBar(
        content: Text(
          "E-mail para recuperar a senha enviado com sucesso",
          style: TextStyle(color: Colors.green),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      snackBar = SnackBar(
        content: Text(
          error.toString(),
          style: TextStyle(color: Colors.red),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).whenComplete(() => Navigator.pop(context));
  }

  _goBackPage(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.background),
                        fit: BoxFit.fitWidth)),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        1.7,
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(104, 202, 138, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  FadeAnimation(
                                      1.7,
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[100]!))),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
                                          validator: (val) {
                                            return RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(val!)
                                                ? null
                                                : "Por favor verifique seu email";
                                          },
                                          controller:
                                              emailTextEdittingController,
                                        ),
                                      )),
                                ],
                              ),
                            ))),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        1.8,
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                AppColors.green,
                                AppColors.green06,
                              ])),
                          child: TextButton(
                            onPressed: () {
                              reset();
                            },
                            child: Center(
                              child: Text("Recuperar Senha",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                      1.8,
                      GestureDetector(
                        onTap: () => _goBackPage(context),
                        child: Container(
                          child: Text(
                            "Fazer login",
                            style: TextStyle(
                              color: AppColors.green,
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
