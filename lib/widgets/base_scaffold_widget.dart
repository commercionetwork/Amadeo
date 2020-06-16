import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:amadeo_flutter/widgets/base_app_bar_widget.dart';

class BaseScaffoldWidget extends StatelessWidget {
  final List<Widget> appBarWidgets;
  final Widget bodyWidget;

  const BaseScaffoldWidget(
      {Key key, this.appBarWidgets, @required this.bodyWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBarWidget(
        title: 'The Amadeo App',
        appBar: AppBar(),
        widgets: appBarWidgets,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return bodyWidget;
        },
      ),
    );
  }
}
