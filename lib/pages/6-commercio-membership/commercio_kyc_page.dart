import 'package:amadeo/pages/export.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/subsection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommercioKYCPage extends SectionPageWidget {
  const CommercioKYCPage({Key key})
      : super('/6-kyc', 'CommercioKYCPage', key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(bodyWidget: CommercioKYCPageBody());
  }
}

class CommercioKYCPageBody extends StatelessWidget {
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
                  sectionPage: BuyMembershipPage(),
                  title: '6.1 Buy a membership with Cash Coins',
                ),
                SubSectionWidget(
                  sectionPage: InviteMemberPage(),
                  title: '6.2 Invite a Member',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
