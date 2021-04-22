
import 'package:flutter/widgets.dart';
import '../main.dart';

class FixWeb {
  bool isWeb = true;//app.isWeb;
  Widget child;
  FixWeb(Widget child){
    this.child = child;
  }

  getExpanded() {
    if (isWeb) {
      return Container(
          child: child
      );
    } else {
      return Expanded(
          child: child
      );
    }
  }

  getPositioned() {
    if (isWeb) {
      return Container(
          child: child
      );
    } else {
      return Positioned(
          child: child
      );
    }
  }

}