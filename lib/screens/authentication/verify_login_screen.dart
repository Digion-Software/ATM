import 'dart:async';

import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/repository/auth_repository.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyLoginScreen extends StatefulWidget {
  const VerifyLoginScreen({
    Key? key,
    required this.phoneNumber,
    required this.isForLogin,
    this.userCountry,
    this.referralCode,
  }) : super(key: key);

  final String? userCountry;
  final String? referralCode;
  final String phoneNumber;
  final bool isForLogin;

  @override
  State<VerifyLoginScreen> createState() => _VerifyLoginScreenState();
}

class _VerifyLoginScreenState extends State<VerifyLoginScreen> with TickerProviderStateMixin {
  final TextEditingController otpController = TextEditingController();
  final StreamController<ErrorAnimationType>? errorController = StreamController<ErrorAnimationType>();
  AnimationController? _controller;
  int levelClock = 30;

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: levelClock));
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Verify Login",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DescriptionTextView(
              data:
                  "Enter Code that we have sent to your phone\n${widget.phoneNumber}",
              fontSize: 14,
              textColor: AppColors.whiteColor),
          SizedBox(
            height: MediaQuery.of(context).size.width / 4,
          ),
          PinCodeTextField(
            appContext: context,
            pastedTextStyle:
                AppTextStyle.buttonTextStyle.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w900),
            textStyle:
                AppTextStyle.buttonTextStyle.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w900),
            autoFocus: true,
            length: 6,
            obscureText: true,
            obscuringCharacter: '*',
            blinkWhenObscuring: true,
            animationType: AnimationType.scale,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            autoDismissKeyboard: true,
            autoDisposeControllers: true,
            autoUnfocus: true,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              activeColor: AppColors.primaryColor,
              errorBorderColor: AppColors.redColor,
              inactiveColor: AppColors.redColor,
              selectedColor: AppColors.primaryColor,
              disabledColor: AppColors.greyColor,
              fieldHeight: 50,
              fieldWidth: 50,
            ),
            cursorColor: AppColors.blackColor,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: false,
            enablePinAutofill: true,
            errorAnimationController: errorController,
            controller: otpController,
            keyboardType: TextInputType.number,
            onCompleted: (v) {},
            onChanged: (value) {},
            beforeTextPaste: (text) {
              return true;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Countdown(
              isForLogin: widget.isForLogin,
              userCountry: widget.userCountry,
              userPhone: widget.phoneNumber,
              referralCode: widget.referralCode,
              animation: StepTween(
                begin: levelClock, // THIS IS A USER ENTERED NUMBER
                end: 0,
              ).animate(_controller!),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 3.5,
          ),
          ButtonView(
            title: "VERIFY",
            textColor: AppColors.whiteColor,
            onTap: () async {
              if (otpController.text.isEmpty) {
                showToast(context: context, msg: "Enter OTP!");
              } else if (otpController.text.length != 6) {
                showToast(context: context, msg: "Enter valid OTP!");
              } else {
                if (widget.isForLogin) {
                  await AuthRepository.login(
                      context: context, userPhoneNumber: widget.phoneNumber, otp: otpController.text);
                } else {
                  await AuthRepository.newRegisterUser(
                      context: context,
                      userCountry: widget.userCountry!,
                      referralCode: widget.referralCode,
                      userPhone: widget.phoneNumber,
                      otp: otpController.text);
                }
              }
              // PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
            },
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation,required this.isForLogin,
  this.userCountry,
  this.userPhone,
  this.referralCode}) : super(key: key, listenable: animation);
  Animation<int> animation;
  final bool isForLogin;
  final String? userCountry;
  final String? userPhone;
  final String? referralCode;
  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return timerText == "0:00" ?
        InkWell(
          onTap: (){
            if(isForLogin){
              AuthRepository.validateAndGetLoginOTP(context: context, userPhoneNumber: userPhone??"",isNeedNavigation: false);
            }
            else {
              AuthRepository.validateAndGetOTPForNewRegister(context: context,
              userCountry: userCountry,
              userPhone: userPhone??"",
              isNeedNavigation: false,
              referralCode: referralCode
              );
            }
          },
          child: Text(
            "Resend OTP",
            style: AppTextStyle.simpleTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600,color: AppColors.primaryColor),
          ),
        )
        :Text(
      timerText,
      style: AppTextStyle.simpleTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}
