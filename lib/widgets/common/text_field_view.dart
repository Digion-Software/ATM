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

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.isObscure,
    required this.controller,
    this.keyBoardType,
    this.onIconTap,
    required this.iconChild,
    this.isReadOnly = false,
    this.textAlignment = TextAlign.start,
  }) : super(key: key);

  final String title;
  final String hintText;
  final bool isObscure;
  final TextEditingController controller;
  final TextInputType? keyBoardType;
  final VoidCallback? onIconTap;
  final Widget iconChild;
  final bool isReadOnly;
  final TextAlign textAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.descriptionTextStyle.copyWith(color: AppColors.blackColor.withOpacity(0.5), fontSize: 16),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.1),
              width: 2,
            ),
          ),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    readOnly: isReadOnly,
                    style: AppTextStyle.simpleTextStyle.copyWith(
                      fontSize: 16,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400,
                    ),
                    keyboardType: keyBoardType,
                    obscureText: isObscure,
                    textAlign: textAlignment,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      hintText: hintText,
                      hintStyle: AppTextStyle.simpleTextStyle.copyWith(
                        fontSize: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: onIconTap,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: iconChild,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
