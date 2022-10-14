import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:flutter/material.dart';

class TextFieldView extends StatelessWidget {
  const TextFieldView({
    Key? key,
    required this.controller,
    this.label = "",
    this.textInputType = TextInputType.text,
    this.cursorColor = AppColors.primaryColor,
    this.topPadding = 15,
  }) : super(key: key);

  final TextInputType textInputType;
  final TextEditingController controller;
  final String label;
  final Color cursorColor;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: topPadding),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTextStyle.simpleTextStyle.copyWith(color: AppColors.greyColor, fontSize: 15),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyColor),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          focusColor: AppColors.primaryColor,
        ),
        keyboardType: textInputType,
        cursorColor: cursorColor,
      ),
    );
  }
}
