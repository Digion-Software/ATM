import 'package:atm/config/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle simpleTextStyle =
      const TextStyle(color: AppColors.blackColor, fontSize: 14, fontWeight: FontWeight.normal, fontFamily: "Roboto");

  static TextStyle titleTextStyle =
      const TextStyle(color: AppColors.blackColor, fontSize: 35, fontWeight: FontWeight.bold, fontFamily: "Roboto");

  static TextStyle descriptionTextStyle =
      const TextStyle(color: AppColors.blackColor, fontSize: 18, fontWeight: FontWeight.w400, fontFamily: "Roboto");

  static TextStyle buttonTextStyle =
      const TextStyle(color: AppColors.blackColor, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: "Roboto");
}
