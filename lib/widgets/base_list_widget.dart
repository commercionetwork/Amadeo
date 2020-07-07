import 'package:flutter/material.dart';

class BaseListWidget extends StatelessWidget {
  final List<Widget> children;
  final double separatorIndent;
  final double separatorEndIndent;
  static const _defaultIndent = 16.0;
  static const _defaultEndIntent = 16.0;

  const BaseListWidget({
    @required this.children,
    this.separatorIndent,
    this.separatorEndIndent,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) => children[i],
      separatorBuilder: (_, __) => Divider(
        indent: separatorIndent ?? _defaultIndent,
        endIndent: separatorEndIndent ?? _defaultEndIntent,
      ),
      itemCount: children.length,
    );
  }
}
