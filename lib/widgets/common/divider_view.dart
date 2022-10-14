import 'package:atm/config/app_colors.dart';
import 'package:flutter/material.dart';

class DividerView extends StatelessWidget {
  const DividerView(
      {Key? key,
      this.dividerHeight = 1,
      this.dividerColor,
      this.topMargin = 5,
      this.bottomMargin = 5,
      this.leftMargin = 10,
      this.rightMargin = 10})
      : super(key: key);

  final double dividerHeight;
  final Color? dividerColor;
  final double topMargin;
  final double bottomMargin;
  final double leftMargin;
  final double rightMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dividerHeight,
      color: dividerColor ?? AppColors.greyColor.withOpacity(0.2),
      margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin, left: leftMargin, right: rightMargin),
    );
  }
}
