
import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:flutter/material.dart';

class ButtonView extends StatelessWidget {
  const ButtonView(
      {Key? key,
      required this.title,
      required this.onTap,
      this.isRoundedBorder = false,
      this.leftPadding = 0,
      this.rightPadding = 0,
      this.topPadding = 15,
      this.bottomPadding = 15,
      this.bottomMargin = 0,
      this.leftMargin = 10,
      this.rightMargin = 10,
      this.topMargin = 0,
      this.textColor,
      this.buttonColor = AppColors.primaryColor})
      : super(key: key);

  final String title;
  final Function() onTap;
  final bool isRoundedBorder;
  final double topPadding;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  final double topMargin;
  final double bottomMargin;
  final double leftMargin;
  final double rightMargin;
  final Color? textColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding, left: leftPadding, right: rightPadding),
        margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin, left: leftMargin, right: rightMargin),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(
            Radius.circular(isRoundedBorder ? 50 : 5),
          ),
        ),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: AppTextStyle.buttonTextStyle.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}

class BackArrowButtonView extends StatelessWidget {
  const BackArrowButtonView(
      {Key? key, this.icon = Icons.arrow_back_ios, this.color = AppColors.blackColor, this.isEnable = true})
      : super(key: key);

  final IconData icon;
  final Color color;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          if (isEnable) {
            PageNavigator.pop(context: context);
          }
        },
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}

class IconButtonView extends StatelessWidget {
  const IconButtonView({Key? key, this.icon = Icons.add, this.color = AppColors.greyColor, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
