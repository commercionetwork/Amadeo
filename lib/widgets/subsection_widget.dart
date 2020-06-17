import 'package:amadeo/pages/export.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:amadeo/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class SubSectionWidget extends StatelessWidget {
  final SectionPageWidget sectionPage;
  final String title;
  final String subtitle;

  const SubSectionWidget({
    @required this.sectionPage,
    @required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(sectionPage.routeName),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 8.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TitleWidget(title),
                        if (subtitle != null) ParagraphWidget(subtitle)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
