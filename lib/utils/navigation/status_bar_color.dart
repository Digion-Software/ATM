import 'package:atm/config/app_colors.dart';
import 'package:flutter/services.dart';

void setTransparentColorToTitleBar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.transparentColor,
    statusBarColor: AppColors.transparentColor,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}
