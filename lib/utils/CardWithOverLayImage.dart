import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CardWithOverLayImage extends StatelessWidget {
  final String url;
  final BuildContext context;
  final String title;
  final String category;
  final String description;

  const CardWithOverLayImage(
      {this.url, this.context, this.title, this.description, this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GFCard(
        boxFit: BoxFit.cover,
        imageOverlay: NetworkImage(url),
        title: GFListTile(
          title: Text(title),
          subTitle: Text(category),
        ),
        content: Text(description),
        border: Border.all(),
      ),
    );
  }
}
