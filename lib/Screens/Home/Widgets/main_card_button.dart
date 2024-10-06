import 'package:flutter/material.dart';

class MainCardButton extends StatelessWidget {
  final String label;
  final String icon;
  final String page;
  final int notification;

  final String valueName;

  final String valueNamePlural;

  const MainCardButton(this.label, this.icon, this.page, this.valueName,
      this.valueNamePlural, this.notification,
      {super.key});

  redirectToPage(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/logged-home'));
    Navigator.of(context).pushNamed(this.page);
  }

  Widget _notification() {
    return notification > 0
        ? Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: FittedBox(child: Text(notification.toString())),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        redirectToPage(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0x99D9E6E8), width: 2),
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 0,
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 2,
                      label,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      valueName == ""
                          ? ""
                          : notification.toString() == "1"
                              ? "$notification $valueName"
                              : "$notification $valueNamePlural",
                      textAlign: TextAlign.left,
                    ),
                    Expanded(
                      child: Image.asset(
                        alignment: Alignment.bottomCenter,
                        "assets/icons/" + this.icon,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
