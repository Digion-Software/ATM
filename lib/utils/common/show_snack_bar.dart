import 'package:atm/config/app_colors.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

void showMessage({required BuildContext context, required String message, bool isErrorMessage = false}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  SnackBar snackBar = SnackBar(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(10),
      elevation: 10,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.transparentColor,
      content: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: isErrorMessage ? AppColors.redColor.withOpacity(0.1) : AppColors.greenColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Icon(
                    Icons.circle_rounded,
                    size: 12,
                    color: isErrorMessage ? AppColors.redColor : AppColors.greenColor,
                  )),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: SimpleTextView(
                  data: message,
                  textColor: isErrorMessage ? AppColors.redColor : AppColors.greenColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
