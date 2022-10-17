import 'package:atm/config/app_colors.dart';
import 'package:flutter/material.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
