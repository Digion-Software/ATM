import 'package:atm/config/api_endpoints.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/models/common/api_response.dart';
import 'package:atm/models/profile/profile_data_model.dart';
import 'package:atm/models/profile/profile_status_model.dart';
import 'package:atm/models/simple_model.dart';
import 'package:atm/repository/auth_repository.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/networking/http_handler.dart';
import 'package:flutter/material.dart';

class ProfileRepository {
  static Future<ProfileDataModel?> getProfileData({required BuildContext context}) async {
    APIResponse apiResponse = await HttpHandler.postMethod(context: context, url: APIEndpoints.profile, data: {
      "is_app": AppConstant.isApp,
      "action": APIActions.getProfileData,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
    });
    if (apiResponse.isSuccess) {
      return profileDataModelFromJson(apiResponse.data);
    } else {
      return null;
    }
  }

  static Future<ProfileStatusModel?> getProfileStatus({required BuildContext context}) async {
    APIResponse apiResponse = await HttpHandler.postMethod(context: context, url: APIEndpoints.profileStatus, data: {
      "is_app": AppConstant.isApp,
      "user_id": await LocalStorage.getString(key: AppConstant.userId),
      "auth_key": await LocalStorage.getString(key: AppConstant.token),
    });
    if (apiResponse.isSuccess) {
      return profileStatusModelFromJson(apiResponse.data);
    } else {
      return profileStatusModelFromJson(apiResponse.data);
    }
  }

  static Future validateAndUpdateProfileData({
    required BuildContext context,
    required String userFirstName,
    required String userLastName,
    required String userEmail,
    required String userDOB,
    required String userGender,
    required String userAddress,
    required Function(bool) isUpdate,
  }) async {
    if (userFirstName.isEmpty) {
      showToast(context: context, msg: "Enter first name.",isError: true);
    } else if (userLastName.isEmpty) {
      showToast(context: context, msg: "Enter last name.",isError: true);
    } else if (userEmail.isEmpty) {
      showToast(context: context, msg: "Enter email address.",isError: true);
    } else if (!isValidEmail(userEmail)) {
      showToast(context: context, msg: "Enter valid email address.",isError: true);
    }
    else if (userDOB.isEmpty) {
      showToast(context: context, msg: "Select your date of birth.",isError: true);
    }
    else if (userGender.isEmpty) {
      showToast(context: context, msg: "Select your Gender.",isError: true);
    }
    else if (userAddress.isEmpty) {
      showToast(context: context, msg: "Enter your Address.",isError: true);
    }
    else {
      showLoadingDialog(context: context);
      APIResponse apiResponse = await HttpHandler.postMethod(context: context, url: APIEndpoints.profile, data: {
        "is_app": AppConstant.isApp,
        "action": APIActions.updateProfile,
        "user_id": await LocalStorage.getString(key: AppConstant.userId),
        "auth_key": await LocalStorage.getString(key: AppConstant.token),
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "user_email": userEmail,
        "user_dob": userDOB,
        "gender": userGender,
        "user_address": userAddress,
      });
      if (apiResponse.isSuccess) {
        SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
        isUpdate(true);
        hideLoadingDialog(context: context);
        showToast(context: context, msg: simpleModel.message);
      } else {
        SimpleModel simpleModel = simpleModelFromJson(apiResponse.data);
        showToast(context: context, msg: simpleModel.message, isError: true);
        hideLoadingDialog(context: context);
      }
    }
  }
}
