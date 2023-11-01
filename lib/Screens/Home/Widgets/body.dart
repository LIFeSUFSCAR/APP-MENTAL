import 'package:app_mental/Services/chatService.dart';
import 'package:app_mental/Services/scaleService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './main_card_button.dart';
import '../../../Services/readingService.dart';
import '../../../helper/helperfuncions.dart';

class Body extends StatefulWidget {
  final String? userName;

  const Body({super.key, required this.userName});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int questionnaireNotificationQuantity = 0;
  int readingNotificationQuantity = 0;
  int chatNotificationQuantity = 0;
  final errorSnackBar = const SnackBar(
      duration: Duration(seconds: 5),
      content: Text("Erro ao tentar se conectar com o servidor!",
          style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red);
  bool snackBarActive = false;

  @override
  void initState() {
    super.initState();
    getQuestionnaireNotification();
  }

  showErrorSnackBar() {
    if (!snackBarActive) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      snackBarActive = true;
    }
  }

  getQuestionnaireNotification() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((email) {
      ScaleService()
          .getQuestionnaireIsReadCount(email)
          .then((notificationQuantity) {
        setState(() {
          questionnaireNotificationQuantity = notificationQuantity;
        });
      }).catchError((_) {
        showErrorSnackBar();
      });
      ReadingService()
          .getReadingIsReadCount(email)
          .then((notificationQuantity) {
        setState(() {
          readingNotificationQuantity = notificationQuantity;
        });
      }).catchError((_) {
        showErrorSnackBar();
      });
      ChatService()
          .getUnreadMessagesQuantity(email)
          .then((notificationQuantity) {
        setState(() {
          chatNotificationQuantity = notificationQuantity;
        });
      }).catchError((_) {
        showErrorSnackBar();
      });
    });
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Tenha um bom dia!';
    }
    if (hour < 17) {
      return 'Tenha uma boa tarde!';
    }
    return 'Tenha uma boa noite!';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xfff6fff5), Color(0xfff1ffef)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.3, 0.6, 1]),
      ),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "Olá, ${widget.userName}.",
                    textAlign: TextAlign.left,
                  ),
                  const Text(
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                    "Tenha um bom dia!",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      DateFormat.yMMMMEEEEd("pt_BR")
                          .format(DateTime.now())
                          .toString(),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              )),
          GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            crossAxisCount: 2,
            children: <Widget>[
              MainCardButton(
                  "Questionários",
                  "questionarios_COR.png",
                  "/quests-screen",
                  "questionário",
                  "questionários",
                  questionnaireNotificationQuantity),
              MainCardButton(
                  "Materiais Educativos",
                  "leitura_COR.png",
                  "/readings",
                  "material",
                  "materiais",
                  readingNotificationQuantity),
              MainCardButton(
                  "Contatos",
                  "contatos_COR.png",
                  "/contacts-chat-screen",
                  "contato",
                  "contatos",
                  chatNotificationQuantity),
              const MainCardButton("Diário livre", "diario_COR.png",
                  "/audio-text-diary", "", "", 0),
            ],
          ),
        
        ],
      ),
    );
  }
}
