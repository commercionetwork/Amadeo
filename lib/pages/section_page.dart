import 'package:flutter/widgets.dart';

abstract class SectionPageWidget extends StatelessWidget {
  final String routeName;
  final String sectionName;

  const SectionPageWidget(this.routeName, this.sectionName, {Key key})
      : super(key: key);
}
