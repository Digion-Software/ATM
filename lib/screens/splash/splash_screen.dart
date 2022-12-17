import 'dart:io' show Platform;

import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/models/app_update/app_update_model.dart';
import 'package:atm/repository/app_update_repository.dart';
import 'package:atm/screens/authentication/login_screen.dart';
import 'package:atm/screens/dashboard/dashboard_screen.dart';
import 'package:atm/screens/onboarding/onboarding_screen.dart';
import 'package:atm/screens/payments/payments_methods_screen.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToHome();
    // Future.delayed(const Duration(seconds: 3),(){
    //   PageNavigator.pushAndRemoveUntilPage(context: context, page: const PaymentsMethodsScreen(amount: 22.88,));
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.appLogo,
          height: 180,
          width: 180,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    AppUpdateModel? appUpdateModel = await AppUpdateRepository.checkAppConfigToUpdate(context: context);
    if (appUpdateModel != null) {
      LocalStorage.setString(key: AppConstant.paymentMethodForDeposit, value: appUpdateModel.data.paymentMethod);
      if (Platform.isAndroid) {
        if (appUpdateModel.data.androidVersion != AppConstant.androidAppVersion) {
          Future.delayed(const Duration(seconds: 0), () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: const Center(
                        child: Text(
                      "Update App",
                      style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                    )),
                    content: const Text(
                      "New version of app is available. Please update app to get better experience.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w400),
                    ),
                    actions: [
                      appUpdateModel.data.androidForceUpdate
                          ? Container()
                          : TextButton(
                              onPressed: () {
                                checkLoginStatus();
                              },
                              child: const Text(
                                "IGNORE",
                                style: TextStyle(color: Colors.red, fontSize: 16),
                              )),
                      TextButton(
                          onPressed: () async {
                            if (await canLaunchUrl(Uri.parse(appUpdateModel.data.androidUrl))) {
                              await launchUrl(Uri.parse(appUpdateModel.data.androidUrl));
                            }
                          },
                          child: const Text(
                            "UPDATE",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ))
                    ],
                  );
                });
          });
        } else {
          checkLoginStatus();
        }
      } else if (Platform.isIOS) {
        if (appUpdateModel.data.iosVersion != AppConstant.iosAppVersion) {
          Future.delayed(const Duration(seconds: 0), () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: const Center(
                        child: Text(
                      "Update App",
                      style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                    )),
                    content: const Text(
                      "New version of app is available. Please update app to get better experience.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w400),
                    ),
                    actions: [
                      appUpdateModel.data.iosForceUpdate
                          ? Container()
                          : TextButton(
                              onPressed: () {
                                checkLoginStatus();
                              },
                              child: const Text(
                                "IGNORE",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                      TextButton(
                          onPressed: () async {
                            if (await canLaunchUrl(Uri.parse(appUpdateModel.data.iosUrl))) {
                              await launchUrl(Uri.parse(appUpdateModel.data.iosUrl));
                            }
                          },
                          child: const Text(
                            "UPDATE",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ))
                    ],
                  );
                });
          });
        } else {
          checkLoginStatus();
        }
      }
    } else {
      checkLoginStatus();
    }
  }

  void checkLoginStatus() async {
    bool? isLogin = await LocalStorage.getBool(key: AppConstant.isLoggedIn);
    if (isLogin == true) {
      bool? isIntroShow = await LocalStorage.getBool(key: AppConstant.isIntroShow);
      if (isIntroShow == true) {
        PageNavigator.pushAndRemoveUntilPage(context: context, page: const OnBoardingScreen());
      } else {
        PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
      }
    } else {
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const LoginScreen());
    }
  }
}
