import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:amadeo_flutter/entities/section_page.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:amadeo_flutter/widgets/section_button_widget.dart';
import 'package:amadeo_flutter/widgets/title_widget.dart';

class SectionCardWidget extends StatelessWidget {
  final SectionPage sectionPage;
  final void Function() onTap;

  const SectionCardWidget({
    Key key,
    @required this.sectionPage,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TitleWidget(sectionPage.title),
            ParagraphWidget(sectionPage.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SectionButtonWidget(sectionPage: sectionPage),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
