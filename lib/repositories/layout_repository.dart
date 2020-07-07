import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class LayoutRepository {
  double _widthPadding;

  double width(BuildContext context) {
    if (_widthPadding != null) {
      return _widthPadding;
    }

    _widthPadding = 0.0;

    if (kIsWeb) {
      _widthPadding = (MediaQuery.of(context).size.width / 12) * 2;
    }

    return _widthPadding;
  }
}
