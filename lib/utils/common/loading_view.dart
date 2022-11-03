import 'package:atm/config/app_colors.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key, this.size = 60}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitFadingCircle(
      color: AppColors.primaryColor,
      size: size,
    ));
  }
}

showLoadingDialog({
  required BuildContext context,
}) {
  showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return const Center(child: LoadingView());
      });
}

hideLoadingDialog({required BuildContext context}) {
  PageNavigator.pop(context: context);
}
