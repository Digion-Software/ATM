import 'package:atm/config/app_text_style.dart';
import 'package:flutter/material.dart';

class SimpleTextView extends StatelessWidget {
  const SimpleTextView({
    Key? key,
    required this.data,
    this.rightPadding = 0,
    this.leftPadding = 0,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.fontWeight,
    this.textColor,
    this.fontSize,
    this.textAlign,
    this.textDecoration,
    this.isTranslate = true,
    this.maxLine,
  }) : super(key: key);

  final String data;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final bool isTranslate;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: rightPadding,
        left: leftPadding,
        top: topPadding,
        bottom: bottomPadding,
      ),
      child: Text(
        data,
        style: AppTextStyle.simpleTextStyle
            .copyWith(color: textColor, fontWeight: fontWeight, fontSize: fontSize, decoration: textDecoration),
        textAlign: textAlign,
        maxLines: maxLine,
      ),
    );
  }
}

class TitleTextView extends StatelessWidget {
  const TitleTextView(
      {Key? key,
        required this.data,
        this.rightPadding = 0,
        this.leftPadding = 0,
        this.topPadding = 0,
        this.bottomPadding = 0,
        this.fontWeight,
        this.textColor,
        this.fontSize,
        this.textAlign,
        this.textDecoration,
        this.isTranslate = true,
        this.maxLine})
      : super(key: key);

  final String data;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final bool isTranslate;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: rightPadding,
        left: leftPadding,
        top: topPadding,
        bottom: bottomPadding,
      ),
      child: Text(
        data,
        style: AppTextStyle.titleTextStyle
            .copyWith(color: textColor, fontWeight: fontWeight, fontSize: fontSize, decoration: textDecoration),
        textAlign: textAlign,
        maxLines: maxLine,
      ),
    );
  }
}

class ButtonTextView extends StatelessWidget {
  const ButtonTextView(
      {Key? key,
        required this.data,
        this.rightPadding = 5,
        this.leftPadding = 5,
        this.topPadding = 5,
        this.bottomPadding = 5,
        this.fontWeight,
        this.textColor,
        this.fontSize,
        this.textAlign,
        this.textDecoration,
        this.isTranslate = true,
        this.maxLine})
      : super(key: key);

  final String data;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final bool isTranslate;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: rightPadding,
        left: leftPadding,
        top: topPadding,
        bottom: bottomPadding,
      ),
      child: Text(
        data,
        style: AppTextStyle.buttonTextStyle
            .copyWith(color: textColor, fontWeight: fontWeight, fontSize: fontSize, decoration: textDecoration),
        textAlign: textAlign,
        maxLines: maxLine,
      ),
    );
  }
}

class DescriptionTextView extends StatelessWidget {
  const DescriptionTextView(
      {Key? key,
        required this.data,
        this.rightPadding = 0,
        this.leftPadding = 0,
        this.topPadding = 5,
        this.bottomPadding = 5,
        this.fontWeight,
        this.textColor,
        this.fontSize,
        this.textAlign,
        this.textDecoration,
        this.isTranslate = true,
        this.maxLine})
      : super(key: key);

  final String data;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final bool isTranslate;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: rightPadding,
        left: leftPadding,
        top: topPadding,
        bottom: bottomPadding,
      ),
      child: Text(
        data,
        style: AppTextStyle.descriptionTextStyle
            .copyWith(color: textColor, fontWeight: fontWeight, fontSize: fontSize, decoration: textDecoration),
        textAlign: textAlign,
        maxLines: maxLine,
      ),
    );
  }
}




