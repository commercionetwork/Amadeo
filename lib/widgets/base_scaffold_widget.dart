import 'package:amadeo_flutter/widgets/base_app_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScaffoldWidget extends StatelessWidget {
  final List<Widget> appBarWidgets;
  final Widget bodyWidget;

  const BaseScaffoldWidget({
    Key key,
    @required this.bodyWidget,
    this.appBarWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBarWidget(title: 'Amadeo', widgets: appBarWidgets),
      body: LayoutBuilder(
        builder: (_, __) => bodyWidget,
      ),
    );
  }
}
