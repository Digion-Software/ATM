import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo(
      {Key? key,
      this.topPadding = 5,
      this.bottomPadding = 5,
      this.rightPadding = 20,
      this.leftPadding = 20,
      this.height,
      this.width})
      : super(key: key);

  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
        left: leftPadding,
        right: rightPadding,
      ),
      child: Image.asset(
        AppImages.appLogo,
        color: AppColors.whiteColor,
        height: height ?? MediaQuery.of(context).size.width / 5,
        width: width ?? MediaQuery.of(context).size.width,
      ),
    );
  }
}
