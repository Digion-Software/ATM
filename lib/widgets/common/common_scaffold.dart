import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    Key? key,
    required this.title,
    required this.child,
    this.horizontalPadding,
    this.onBackPressed,
  }) : super(key: key);
  final String title;
  final Widget child;
  final double? horizontalPadding;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          const Image(image: AssetImage(AppImages.bgShape)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      BackArrowButtonView(
                        color: AppColors.whiteColor,
                        onPressed: onBackPressed,
                      ),
                      TitleTextView(
                          data: title,
                          textColor: AppColors.whiteColor,
                          fontSize: 24,
                          topPadding: 15,
                          bottomPadding: 15),
                    ],
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
