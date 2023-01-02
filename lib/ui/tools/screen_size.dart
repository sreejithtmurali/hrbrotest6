import 'package:flutter/widgets.dart';

class ScreenSize {
  static late MediaQueryData data;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double width;
  static late double height;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static void init(BuildContext context) {
    data = MediaQuery.of(context);
    width = data.size.width;
    height = data.size.height;
    blockSizeHorizontal = width / 100;
    blockSizeVertical = height / 100;
    _safeAreaHorizontal = data.padding.left + data.padding.right;
    _safeAreaVertical = data.padding.top + data.padding.bottom;
    safeBlockHorizontal = (width - _safeAreaHorizontal) / 100;
    safeBlockVertical = (height - _safeAreaVertical) / 100;
  }
}
