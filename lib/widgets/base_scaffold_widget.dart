import 'package:amadeo/repositories/layout_repository.dart';
import 'package:amadeo/widgets/base_app_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.repository<LayoutRepository>().width(context),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: BaseAppBarWidget(title: 'Amadeo', widgets: appBarWidgets),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (_, __) => bodyWidget,
          ),
        ),
      ),
    );
  }
}
