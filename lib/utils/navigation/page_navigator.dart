import 'package:flutter/cupertino.dart';

class PageNavigator {
  static Future<dynamic> pushPage({required BuildContext context, required Widget page}) {
    return Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
  }

  static Future<dynamic> pushAndRemoveUntilPage({required BuildContext context, required Widget page}) {
    return Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => page), (route) => false);
  }

  static Future<dynamic> pushReplacementPage({required BuildContext context, required Widget page}) {
    return Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => page));
  }

  static void pop({required BuildContext context}) {
    return Navigator.of(context).pop();
  }
}
