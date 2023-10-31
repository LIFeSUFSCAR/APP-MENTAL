import 'dart:convert';

import 'package:app_mental/Screens/Reading/Text/Widgets/carousel.dart';
import 'package:app_mental/Screens/Reading/Text/Widgets/text_card.dart';
import 'package:app_mental/Screens/Reading/Text/Widgets/video_player.dart';
import 'package:flutter/material.dart';

import '../../../../classes/reading_carousel_database.dart';
import '../../../../model/reading.dart';
import '../text_screen.dart';

class TextBody extends StatefulWidget {
  const TextBody(this.text, this.relatedReadingList,
      this.verifyNotificationList, this.carouselImages,
      {super.key});

  final String text;
  final List<Reading> relatedReadingList;
  final Function verifyNotificationList;
  final List<String> carouselImages;

  @override
  State<TextBody> createState() => _TextBodyState();
}

class _TextBodyState extends State<TextBody> {
  List<Widget> getText() {
    var mediaQuantity = '<figure class="media">'.allMatches(widget.text).length;
    if (mediaQuantity > 0) {
      List<Widget> widgetList = [];
      String text = widget.text;
      for (int i = 0; i < mediaQuantity; i++) {
        List firstPartText = text.split('<figure class="media">');
        if (firstPartText[0].length > 0) {
          widgetList.add(TextCard(text: firstPartText[0]));
        }
        List splitMediaUrl = firstPartText[1].split('watch?v=');
        List mediaUrl = splitMediaUrl[1].split('&');
        widgetList.add(VideoPlayer(videoUrl: mediaUrl[0]));
        List textSplited2 = firstPartText[1].split('</figure>');
        if (i + 1 < mediaQuantity) {
          int textIndex = text.indexOf('</figure>');
          text = text.substring(textIndex + "</figure>".length);
        } else {
          widgetList.add(TextCard(text: textSplited2[1]));
        }
      }
      return widgetList;
    } else {
      return [TextCard(text: widget.text)];
    }
  }

  goToRelatedReading(Reading reading) {
    widget.verifyNotificationList(reading.name, reading.group);
    Navigator.pop(context);
    ReadingCarouselDatabase.instance
        .getImagesById(reading.id!)
        .then((carouselImages) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return TextScreen(
              title: reading.name,
              text: reading.text,
              id: reading.id,
              relatedReadings: reading.idRelatedReading,
              verifyNotificationList: widget.verifyNotificationList,
              carouselImages: carouselImages,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 18.0, bottom: 28.0, right: 16, left: 16),
            child: Column(
              children: [
                widget.carouselImages.isNotEmpty
                    ? Column(
                        children: [
                          Carousel(carouselImages: widget.carouselImages),
                        ],
                      )
                    : Container(),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 4, 10, 4),
                    child: Column(
                      children: getText(),
                    ),
                  ),
                ),
                const Divider(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Materiais Educativos Relacionados",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 192,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.relatedReadingList.length,
                    itemBuilder: (context, index) {
                      Reading reading = widget.relatedReadingList[index];
                      return GestureDetector(
                          onTap: () => goToRelatedReading(reading),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 110,
                                      height: 100,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: (reading.iconGroupImage != null
                                            ? Image.memory(base64Decode(
                                                reading.iconGroupImage!))
                                            : null),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: 110,
                                      height: 40,
                                      child: Text(
                                        reading.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ))) /**/;
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 50))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
