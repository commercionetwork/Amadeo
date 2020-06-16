import 'package:flutter/material.dart';

class ParagraphWidget extends StatelessWidget {
  final String paragraph;
  final EdgeInsetsGeometry padding;

  const ParagraphWidget(this.paragraph,
      {this.padding = const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      )});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Text(
        paragraph,
      ),
    );
  }
}
