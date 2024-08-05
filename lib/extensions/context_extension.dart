import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

extension MediaQueryExtension on BuildContext {
  double get mediaQueryWidth => MediaQuery.of(this).size.width;

  double get mediaQueryHeight => MediaQuery.of(this).size.height;
}
extension SizedBoxValue on num {
  SizedBox get SizedBoxHeight => SizedBox(height:toDouble());

  SizedBox get SizedBoxWidth => SizedBox(width:toDouble());
}
