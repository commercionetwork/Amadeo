import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;

  const TitleWidget(this.title, {this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
