import 'package:amadeo/entities/section_page.dart';
import 'package:flutter/material.dart';

class SectionButtonWidget extends StatelessWidget {
  final SectionPage sectionPage;

  const SectionButtonWidget({
    Key key,
    @required this.sectionPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: FlatButton(
        onPressed: sectionPage.enabled
            ? () => Navigator.pushNamed(
                  context,
                  sectionPage.sectionPageWidget.routeName,
                )
            : null,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Text(sectionPage.title),
      ),
    );
  }
}
