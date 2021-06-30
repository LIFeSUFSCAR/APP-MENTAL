import 'dart:ui';

import 'package:chat_app_tutorial/helper/helperfuncions.dart';
import 'package:chat_app_tutorial/Services/database.dart';
import 'package:chat_app_tutorial/main.dart';
import 'package:flutter/material.dart';
// import './categories_screen.dart';

class Promisn1Result extends StatelessWidget {
  final List<int> resultScoreList;
  final String questName;
  final String userEscala;
  final String userEmail;
  final int questionIndex;
  final DateTime now = DateTime.now();
  //final Function resetHandler;
  final String resultPhrase =
      'Questionário concluído! \n\nFique atento às próximas atividades.';

  final DatabaseMethods databaseMethods = new DatabaseMethods();

  enviarDominios(String email) async {
    Map<String, dynamic> promisn1Map = {
      "dom1": resultScoreList[1],
      "dom2": resultScoreList[2],
      "dom3": resultScoreList[3],
      "dom4": resultScoreList[4],
      "dom5": resultScoreList[5],
      "dom6": resultScoreList[6],
      "dom7": resultScoreList[7],
      "dom8": resultScoreList[8],
      "dom9": resultScoreList[9],
      "dom10": resultScoreList[10],
      "dom11": resultScoreList[11],
      "dom12": resultScoreList[12],
      "dom13": resultScoreList[13],
      "answeredAt": now,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    print("EnviarDominios userEmail/userEscala PromisResult");
    print(email);
    print(userEscala);
    databaseMethods.addQuestAnswer(promisn1Map, email, userEscala);
    var query =
        await databaseMethods.getDomFromAnswers(userEmail, userEscala, "dom1");

    if (query.docs[0].get("dom1") > 2) {
      Map<String, dynamic> questMap = {
        "unanswered?": true,
        "questId": "pn2",
        "questName": "PROMIS Nível 2",
        "availableAt": now,
        "userEscala": "$userEscala-promisn2",
        "answeredUntil": 0,
      };
      DatabaseMethods().createQuest("promisN2", questMap, email);
    }
    ;
    DatabaseMethods().updateQuestIndex(userEscala, email, questionIndex);
    DatabaseMethods().disableQuest(userEscala, email);
  }

  Promisn1Result({
    this.resultScoreList,
    this.questName,
    this.userEscala,
    this.userEmail,
    this.questionIndex,
  });

  /* void _returnMenu(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesScreen.routeName,
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        resultPhrase,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
      Spacer(),
      Container(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(104, 202, 138, 1)),
          child: const Text('Enviar minhas respostas',
              style: TextStyle(color: Colors.black)),
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Confirmar'),
                content: const Text(
                    'Suas respostas serão enviadas, e analisadas anonimamente para a recomendação de novas atividades.\nEstá de acordo?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () async {
                      enviarDominios(userEmail);
                      Navigator.pop(context, 'Estou de acordo');
                      await Navigator.of(context).push(
                          new MaterialPageRoute(builder: (context) => MyApp()));
                      //Navigator.pop(context, 'OK');
                    },
                    child: const Text('Estou de acordo'),
                  ),
                ],
              ),
            );
          },
        ),
      )
    ]);
    //Future.delayed(Duration.zero, () => showAlert(context));

    /*return Container(
        /*FlatButton(
          child: Text('Retornar ao menu'),
          textColor: Colors.blue,
          onPressed: () => {
            Navigator.of(context).pushNamed(
              CategoriesScreen.routeName,
              arguments: {},
            )
          },
        ),*/

        );*/
  }

  void showAlert(BuildContext context) {
    Widget voltarButton = TextButton(
      child: Text("Voltar",
          style: TextStyle(color: Color.fromRGBO(0, 175, 185, 1))),
      onPressed: () async {
        /*var count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });*/
        enviarDominios(userEmail);
        Navigator.pop(context, 'Voltar');
        await Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) => MyApp()));
      },
    );
    // configura o  Alert
    Widget alert = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text(
            "Parabéns por responder ao questionário!!",
            textAlign: TextAlign.center,
          ),
          content: Image(image: AssetImage('assets/images/unicorn.png')),
          actions: [
            voltarButton,
          ],
        ));
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
