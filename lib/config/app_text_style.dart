import 'package:atm/config/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle simpleTextStyle = const TextStyle(
    color: AppColors.blackColor,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static TextStyle titleTextStyle = const TextStyle(
    color: AppColors.blackColor,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static TextStyle descriptionTextStyle =
      const TextStyle(color: AppColors.blackColor, fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle buttonTextStyle =
      const TextStyle(color: AppColors.blackColor, fontSize: 16, fontWeight: FontWeight.w600);
}
