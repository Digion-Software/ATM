class AppConstant {
  AppConstant._();

  static const String androidAppVersion = "1";
  static const String iosAppVersion = "1";
  static const int isApp = 1;

  //AUTHENTICATION AND USER DETAILS
  static const String token = "TOKEN";
  static const String userId = "USER-ID";
  static const String deviceId = "DEVICE-ID";
  static const String latitude = "LATITUDE";
  static const String longitude = "LONGITUDE";
  static const String deviceCity = "DEVICE-CITY";
  static const String deviceState = "DEVICE-STATE";
  static const String deviceCountry = "DEVICE-COUNTRY";

  static const String isLoggedIn = "IS-LOGIN";
  static const String userDetails = "USER-DETAILS";
  static const String userName = "USER-NAME";
  static const String countriesModel = "COUNTRIES-MODEL";
  static const String paymentMethodForDeposit = "PAYMENT-METHOD-FOR-DEPOSIT";
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
  static const String ticketOption = "customer_support_subject";
  static const String getPlanList = "get_plan_list";
  static const String requestOTP = "request_otp";
  static const String addTransfer = "add_transfer";
}
