import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/authentication/countries_model.dart';
import 'package:atm/models/authentication/login_model.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/simple_model.dart';
import 'package:atm/screens/authentication/login_screen.dart';
import 'package:atm/screens/authentication/verify_login_screen.dart';
import 'package:atm/screens/onboarding/onboarding_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  static Future validateAndGetOTPForNewRegister({
    required BuildContext context,
    required String? userCountry,
    required String userPhone,
    String? referralCode,
    bool isNeedNavigation = true,
  }) async {
    if (userCountry == null || userCountry.isEmpty) {
      showToast(context: context, msg: "Select your country.", isError: true);
    } else if (userPhone.isEmpty) {
      showToast(context: context, msg: "Enter phone number.", isError: true);
    } else if (userPhone.length < 4 || userPhone.length > 12) {
      showToast(context: context, msg: "Enter valid phone number", isError: true);
    } else {
      showLoadingDialog(context: context);
      APIResponse response = await HttpHandler.postMethod(context: context, url: APIEndpoints.newRegister, data: {
        "user_country": userCountry,
        "is_app": AppConstant.isApp,
        "action": APIActions.sendOTP,
        "user_phone": userPhone
      });
      if (response.isSuccess) {
        hideLoadingDialog(context: context);
        SimpleModel simpleModel = simpleModelFromJson(response.data);
        if (isNeedNavigation) {
          PageNavigator.pushPage(
              context: context,
              page: VerifyLoginScreen(
                phoneNumber: userPhone,
                userCountry: userCountry,
                referralCode: referralCode,
                isForLogin: false,
              ));
        }
        showToast(context: context, msg: simpleModel.message, isError: true);
      } else {
        hideLoadingDialog(context: context);
        SimpleModel simpleModel = simpleModelFromJson(response.data);
        showToast(context: context, msg: simpleModel.message, isError: true);
      }
    }
  }

  static Future newRegisterUser({
    required BuildContext context,
    required String userCountry,
    required String userPhone,
    required String otp,
    String? referralCode
  }) async {
    showLoadingDialog(context: context);
    Map<String,dynamic> requestData = {
      "user_country": userCountry,
      "user_phone": userPhone,
      "otp": otp,
      "device_id": await LocalStorage.getString(key: AppConstant.deviceId),
      "latitude": await LocalStorage.getDouble(key: AppConstant.latitude),
      "longitude": await LocalStorage.getDouble(key: AppConstant.longitude),
      "device_city": await LocalStorage.getString(key: AppConstant.deviceCity),
      "device_state": await LocalStorage.getString(key: AppConstant.deviceState),
      "device_country": await LocalStorage.getString(key: AppConstant.deviceCountry),

    };

    if(referralCode != null && referralCode != "")
    {
      requestData.addAll({"referral_code" : referralCode});
    }
    APIResponse response = await HttpHandler.postMethod(context: context, url: APIEndpoints.createUser, data: requestData );
    // if (response.isSuccess) {
    //   SimpleModel simpleModel = simpleModelFromJson(response.data);
    //   hideLoadingDialog(context: context);
    //   PageNavigator.pushAndRemoveUntilPage(context: context, page: const LoginScreen());
    //   showToast(msg: simpleModel.message, context: context);
    // } else {
    //   SimpleModel simpleModel = simpleModelFromJson(response.data);
    //   hideLoadingDialog(context: context);
    //   showToast(msg: simpleModel.message, isError: true, context: context);
    // }
    if (response.isSuccess) {
      hideLoadingDialog(context: context);
      LoginModel loginModel = loginModelFromJson(response.data);
      LocalStorage.setString(key: AppConstant.token, value: loginModel.userData!.authKey);
      LocalStorage.setString(key: AppConstant.userId, value: loginModel.userData!.userId);
      LocalStorage.setString(key: AppConstant.userDetails, value: loginModelToJson(loginModel));
      if (loginModel.userData != null) {
        if (loginModel.userData!.name.isNotEmpty) {
          LocalStorage.setString(key: AppConstant.userName, value: loginModel.userData!.name);
        }
      }

      LocalStorage.setBool(key: AppConstant.isLoggedIn, value: true);
      LocalStorage.setBool(key: AppConstant.isIntroShow, value: true);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const OnBoardingScreen());
      showToast(msg: loginModel.message ?? "--", context: context);
    } else {
      hideLoadingDialog(context: context);
      LoginModel loginModel = loginModelFromJson(response.data);
      showToast(msg: loginModel.message ?? "--", isError: true, context: context);
    }
  }

  static Future validateAndGetLoginOTP(
      {required BuildContext context, required String userPhoneNumber, bool isNeedNavigation = true}) async {
    if (userPhoneNumber.isEmpty) {
      showToast(context: context, msg: 'Phone number is required.', isError: true);
    } else if (userPhoneNumber.length < 10) {
      showToast(context: context, msg: 'Enter valid phone number.', isError: true);
    } else {
      showLoadingDialog(context: context);
      APIResponse response = await HttpHandler.postMethod(
          context: context,
          url: APIEndpoints.login,
          data: {"username": userPhoneNumber, "is_app": AppConstant.isApp, "action": APIActions.sendOTP});
      if (response.isSuccess) {
        hideLoadingDialog(context: context);
        SimpleModel simpleModel = simpleModelFromJson(response.data);
        if (isNeedNavigation) {
          PageNavigator.pushPage(
              context: context,
              page: VerifyLoginScreen(
                isForLogin: true,
                phoneNumber: userPhoneNumber,
              ));
        }
        showToast(msg: simpleModel.message, context: context);
      } else {
        hideLoadingDialog(context: context);
        SimpleModel simpleModel = simpleModelFromJson(response.data);
        showToast(msg: simpleModel.message, isError: true, context: context);
      }
    }
  }

  static Future login({required BuildContext context, required String userPhoneNumber, required String otp}) async {
    showLoadingDialog(context: context);
    APIResponse response = await HttpHandler.postMethod(
        context: context,
        url: APIEndpoints.login,
        data: {"username": userPhoneNumber, "is_app": AppConstant.isApp, "action": APIActions.verifyOTP, "otp": otp});
    if (response.isSuccess) {
      hideLoadingDialog(context: context);
      LoginModel loginModel = loginModelFromJson(response.data);
      LocalStorage.setString(key: AppConstant.token, value: loginModel.userData!.authKey);
      LocalStorage.setString(key: AppConstant.userId, value: loginModel.userData!.userId);
      LocalStorage.setString(key: AppConstant.userDetails, value: loginModelToJson(loginModel));
      if (loginModel.userData != null) {
        if (loginModel.userData!.name.isNotEmpty) {
          LocalStorage.setString(key: AppConstant.userName, value: loginModel.userData!.name);
        }
      }
      LocalStorage.setBool(key: AppConstant.isLoggedIn, value: true);
      LocalStorage.setBool(key: AppConstant.isIntroShow, value: true);
      PageNavigator.pushAndRemoveUntilPage(context: context, page: const OnBoardingScreen());
      showToast(msg: loginModel.message ?? "--", context: context);
    } else {
      hideLoadingDialog(context: context);
      LoginModel loginModel = loginModelFromJson(response.data);
      showToast(msg: loginModel.message ?? "--", isError: true, context: context);
    }
  }

  static Future<CountriesModel?> getCounties({required BuildContext context}) async {
    APIResponse response = await HttpHandler.getMethod(url: APIEndpoints.getCountries);
    if (response.isSuccess) {
      CountriesModel countriesModel = countriesModelFromJson(response.data);
      return countriesModel;
    } else {
      return null;
    }
  }

  static Future<void> logout(BuildContext context) async {
    await LocalStorage.clearStorage();
    PageNavigator.pushAndRemoveUntilPage(context: context, page: const LoginScreen());
  }
}

bool isValidEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(email);
}
