import 'package:amadeo_flutter/pages/2-commercio-id/export.dart';
import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/subsection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommercioIdPage extends SectionPageWidget {
  const CommercioIdPage({Key key})
      : super('/2-id', 'CommercioIdPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(bodyWidget: CommercioIdBody());
  }
}

class CommercioIdBody extends StatelessWidget {
  const CommercioIdBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: const [
                SubSectionWidget(
                  sectionPage: CreateDDOPage(),
                  title: '2.1 Create a Ddo',
                ),
                SubSectionWidget(
                  sectionPage: RequestPowerupPage(),
                  title: '2.2 Request Powerup',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
