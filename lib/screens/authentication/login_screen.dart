import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/repository/auth_repository.dart';
import 'package:atm/screens/authentication/signup_screen.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/authentication/authentication_view.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();

  // TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Image.asset(
                AppImages.appLogo,
                height: 120,
                width: 120,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: AuthenticationView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleTextView(data: "Sign in", fontSize: 28),
                  SimpleTextView(
                    data: "Sign to your account",
                    fontSize: 16,
                    textColor: AppColors.blackColor.withOpacity(0.5),
                    topPadding: 10,
                  ),
                  const SizedBox(height: 30),
                  CommonTextField(
                    title: "Email",
                    hintText: "Enter email",
                    controller: phoneNumberController,
                    iconChild: const SizedBox(),
                    isObscure: false,
                  ),
                  // const SizedBox(height: 20),
                  // CommonTextField(
                  //   title: "OTP",
                  //   hintText: "XXXX",
                  //   controller: otpController,
                  //   iconChild: const SizedBox(),
                  //   isObscure: false,
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.width / 5),
                  ButtonView(
                    title: "GET VERIFICATION CODE",
                    textColor: AppColors.whiteColor,
                    onTap: () async {
                      await AuthRepository.validateAndGetLoginOTP(
                          context: context, userPhoneNumber: phoneNumberController.text);
                      // PageNavigator.pushPage(
                      //     context: context, page: const VerifyLoginScreen(isForLogin: true, phoneNumber: "9999999999"));
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimpleTextView(
                        data: "Don't have an account?",
                        textColor: AppColors.blackColor.withOpacity(0.5),
                        fontSize: 16,
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () async {
                          PageNavigator.pushPage(context: context, page: const SignUpScreen());
                        },
                        child: const SimpleTextView(
                          data: "Sign Up",
                          textColor: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
