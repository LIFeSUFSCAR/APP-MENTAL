import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatelessWidget {
  final List<String> carouselImages;

  Carousel({required this.carouselImages});

  closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  showImageContainer(BuildContext context, Image image) async {
    await showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Stack(
          children: [
            InteractiveViewer(maxScale: 2, child: image),
            Positioned(
              right: 0,
              top: 0,
              child: InkResponse(
                onTap: () => closeDialog(context),
                child: const CircleAvatar(
                  maxRadius: 15,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          enlargeCenterPage: true,
          enlargeFactor: 0.1,
          autoPlay: true, height: MediaQuery.of(context).size.height * 0.3),
      items: carouselImages.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(

              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.1)),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: GestureDetector(
                onTap: () => showImageContainer(
                    context,
                    Image.memory(
                      base64Decode(i),
                    )),
                child: Image.memory(
                  base64Decode(i),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
