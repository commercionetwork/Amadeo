import 'package:amadeo/entities/section_page.dart';
import 'package:flutter/material.dart';

class SectionButtonWidget extends StatelessWidget {
  final SectionPage sectionPage;

  const SectionButtonWidget({
    required this.sectionPage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: sectionPage.enabled
            ? () => Navigator.pushNamed(
                  context,
                  sectionPage.sectionPageWidget.routeName,
                )
            : null,
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        child: Text(sectionPage.title),
      ),
    );
  }
}
