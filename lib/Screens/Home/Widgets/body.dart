import 'package:app_mental/Services/scaleService.dart';
import 'package:flutter/material.dart';
import '../../../Services/readingService.dart';
import '../../../Services/sleepService.dart';
import '../../../helper/helperfuncions.dart';
import './main_card_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int questionnaireNotificationQuantity = 0;
  int sleepDiaryNotificationQuantity = 0;
  int readingNotificationQuantity = 0;

  @override
  void initState() {
    super.initState();
    getQuestionnaireNotification();
  }

  getQuestionnaireNotification() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((email) {
      ScaleService()
          .getQuestionnaireIsReadCount(email)
          .then((notificationQuantity) {
        setState(() {
          questionnaireNotificationQuantity = notificationQuantity;
        });
      });
      SleepService().isSleepDiaryAnsweredToday(email).then((answered) {
        setState(() {
          if (answered) {
            sleepDiaryNotificationQuantity = 0;
          } else {
            sleepDiaryNotificationQuantity = 1;
          }
        });
      });
      ReadingService()
          .getReadingIsReadCount(email)
          .then((notificationQuantity) {
        setState(() {
          readingNotificationQuantity = notificationQuantity;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainCardButton("Diário do sono", Icons.bed, "/sleep-diary",
                  sleepDiaryNotificationQuantity),
              MainCardButton("Leitura", Icons.book_online, "/readings",
                  readingNotificationQuantity)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainCardButton("Questionários", Icons.list_alt, "/quests-screen",
                  questionnaireNotificationQuantity),
              MainCardButton("Contatos", Icons.people, "/contacts-screen", 0)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainCardButton("Tutorial", Icons.book, "/tutorial", 0),
              MainCardButton(
                  "Diário livre", Icons.book_outlined, "/audio-text-diary", 0),
            ],
          ),
        ],
      ),
    );
  }
}
