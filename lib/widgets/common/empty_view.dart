import 'package:atm/config/app_text_style.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    Key? key,
    required this.content,
    this.alignment = Alignment.topRight,
    this.width,
    this.height,
  }) : super(key: key);

  final Widget content;
  final Alignment? alignment;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("NO DATA FOUND !",style: AppTextStyle.descriptionTextStyle),);
  }
}
