import 'package:app_mental/Screens/Home/Widgets/main_card_button.dart';
import 'package:app_mental/constants.dart';
import 'package:flutter/material.dart';

import '../../Services/chatService.dart';
import '../../helper/helperfuncions.dart';

class ContactChatScreen extends StatefulWidget {
  static const routeName = '/contacts-chat-screen';

  @override
  State<ContactChatScreen> createState() => _ContactChatScreenState();
}

class _ContactChatScreenState extends State<ContactChatScreen> {
  int chatNotificationQuantity = 0;

  @override
  void initState() {
    getChatNotification();
    super.initState();
  }

  getChatNotification() async {
    await HelperFunctions.getUserEmailInSharedPreference().then((userEmail) {
      ChatService()
          .getUnreadMessagesQuantity(userEmail)
          .then((notificationQuantity) {
        setState(() {
          chatNotificationQuantity = notificationQuantity;
        });
      });
    });
  }

  _goBackPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed("/logged-home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        shadowColor: Colors.transparent,
        title: const Text("Contatos"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _goBackPage(context),
        ),
      ),
      body: Column(

        children: [GridView.count(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
          children: <Widget>[
            const MainCardButton("Contatos de Emergência", "contatos_COR.png",
                "/contacts-screen","", "", 0),
            MainCardButton("Chat", "contatos_COR.png", "/chat","conversa", "conversas",
                chatNotificationQuantity),
          ],
        ),
      ]),
    );
  }
}
