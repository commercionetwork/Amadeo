import 'package:amadeo/pages/export.dart';
import 'package:flutter/material.dart';

class SubSectionWidget extends StatelessWidget {
  final SectionPageWidget sectionPage;
  final String title;
  final String subtitle;

  const SubSectionWidget({
    required this.sectionPage,
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(sectionPage.routeName),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
