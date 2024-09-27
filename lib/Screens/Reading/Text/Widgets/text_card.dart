import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    required this.text}
  );

  final String text;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: text,
      style: {
        "body": Style(
          lineHeight: LineHeight.number(1.3),
        ),
      },
      onLinkTap: (url, context, attributes) => launchUrl(Uri(
        scheme: 'https',
        host: url,
      )),
    );
  }
}
