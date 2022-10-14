import 'package:flutter/material.dart';

void openDrawerMenu({required GlobalKey<ScaffoldState> scaffoldKey}) {
  if (scaffoldKey.currentState != null) {
    scaffoldKey.currentState!.openDrawer();
  }
}
