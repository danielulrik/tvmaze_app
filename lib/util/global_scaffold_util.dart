// https://www.youtube.com/watch?v=JdYP9YoO6gU
// asuka dependece

import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class GlobalScaffoldUtil {
  static final instance = GlobalScaffoldUtil();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(String text, {Color backgroundColor, Duration duration}) {
    var _snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: backgroundColor,
      duration: duration ?? Duration(seconds: 2),
    );
    scaffoldKey.currentState.showSnackBar(_snackBar);
  }

  void showDialog(String text) {}

  showBottomSheet(
      dynamic child, {
        Function closed,
        Color backgroundColor,
        bool isDismissible = true,
      }) {
    var modal = showModalBottomSheet(
      context: navigatorPlus.currentContext,
      backgroundColor: backgroundColor,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return child;
      },
    );
    modal.then((value) {
      print("bottomSheetController: $value");
      if (closed != null) {
        closed();
      }
    });
  }
}
