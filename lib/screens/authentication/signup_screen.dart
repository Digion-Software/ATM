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
                  const TitleTextView(data: "Sign up"),
                  const SizedBox(height: 10),
                  const DescriptionTextView(data: "Create an account to continue!"),
                  const SizedBox(height: 30),
                  CommonTextField(
                    title: "First Name",
                    hintText: "Vikas",
                    controller: firstNameController,
                    iconChild: const SizedBox(),
                    isObscure: false,
                  ),
                  const SizedBox(height: 20),
                  CommonTextField(
                    title: "Last Name",
                    hintText: "Patel",
                    controller: lastNameController,
                    iconChild: const SizedBox(),
                    isObscure: false,
                  ),
                  const SizedBox(height: 20),
                  CommonTextField(
                    title: "Email",
                    hintText: "vikaspatel@gmail.com",
                    controller: emailController,
                    iconChild: const SizedBox(),
                    isObscure: false,
                  ),
                  const SizedBox(height: 20),
                  CommonTextField(
                    title: "Phone",
                    hintText: "9999999999",
                    controller: phoneController,
                    iconChild: const SizedBox(),
                    isObscure: false,
                  ),
                  const SizedBox(height: 20),
                  ButtonView(
                    title: "SIGN UP",
                    textColor: AppColors.whiteColor,
                    onTap: () async{
                      await AuthRepository.validateAndGetOTPForNewRegister(
                          context: context,
                          userFirstName: firstNameController.text,
                          userLastName: lastNameController.text,
                          userEmailAddress: emailController.text,
                          userPhone: phoneController.text);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const DescriptionTextView(data: "You Already have an account?"),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                         PageNavigator.pop(context: context);
                        },
                        child: const DescriptionTextView(
                          data: "Sign In",
                          textColor: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
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
