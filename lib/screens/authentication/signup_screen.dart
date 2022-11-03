import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/repository/auth_repository.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/authentication/authentication_view.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Image.asset(
                AppImages.appLogo,
                height: 120,
                width: 120,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: AuthenticationView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleTextView(data: "Sign up", fontSize: 28),
                  SimpleTextView(
                      data: "Create an account to continue!",
                      textColor: AppColors.blackColor.withOpacity(0.5),
                      topPadding: 10,
                      fontSize: 16),
                  const SizedBox(height: 30),
                  CommonTextField(
                    title: "First Name",
                    hintText: "Enter First Name",
                    controller: firstNameController,
                    iconChild: const SizedBox(),
                    isObscure: false,
                  ),
                  const SizedBox(height: 20),
                  CommonTextField(
                    title: "Last Name",
                    hintText: "Enter Last Name",
                    controller: lastNameController,
                    iconChild: const SizedBox(),
                    isObscure: false,
                  ),
                  const SizedBox(height: 20),
                  CommonTextField(
                    title: "Email",
                    hintText: "Enter Email",
                    controller: emailController,
                    iconChild: const SizedBox(),
                    isObscure: false,
                  ),
                  const SizedBox(height: 20),
                  CommonTextField(
                    title: "Phone",
                    hintText: "Enter Phone Number",
                    controller: phoneController,
                    iconChild: const SizedBox(),
                    isObscure: false,
                  ),
                  const SizedBox(height: 20),
                  ButtonView(
                    title: "SIGN UP",
                    textColor: AppColors.whiteColor,
                    onTap: () async {
                      await AuthRepository.validateAndGetOTPForNewRegister(
                          context: context,
                          userFirstName: firstNameController.text,
                          userLastName: lastNameController.text,
                          userEmailAddress: emailController.text,
                          userPhone: phoneController.text);
                      // PageNavigator.pushPage(
                      //     context: context, page: const VerifyLoginScreen(phoneNumber: "test98@gmail.com", isForLogin: false));
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimpleTextView(
                          data: "You Already have an account?",
                          textColor: AppColors.blackColor.withOpacity(0.5),
                          fontSize: 16),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          PageNavigator.pop(context: context);
                        },
                        child: const SimpleTextView(
                            data: "Sign In",
                            textColor: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
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
