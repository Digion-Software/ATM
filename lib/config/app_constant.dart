class AppConstant {
  AppConstant._();

  static const String androidAppVersion = "1";
  static const String iosAppVersion = "1";
  static const int isApp = 1;

  //AUTHENTICATION AND USER DETAILS
  static const String token = "TOKEN";
  static const String userId = "USER-ID";
  static const String isLoggedIn = "IS-LOGIN";
  static const String userDetails = "USER-DETAILS";
}

class APIActions {
  static const String sendOTP = "send_otp";
  static const String verifyOTP = "verify_otp";
  static const String updateProfile = "update_profile";
  static const String getWithdrawal = "get_withdrawal";
  static const String buyPackage = "buy_package";
  static const String bankEdit = "bank_edit";
  static const String bankDelete = "bank_delete";
  static const String getBankList = "get_bank_list";
  static const String getBankDetails = "get_bank_details";
  static const String bankAdd = "bank_add";
  static const String getProfileData = "get_profile_data";
  static const String capitalWithdrawal = "capital_withdrawal";
  static const String profitWithdrawal = "profit_withdrawal";
}
