class APIEndpoints {
  APIEndpoints._();

  static const String baseUrl = "https://atm.alphapixclients.com/";
  static const String hostUrl = "ajaxfiles/";

  ///APP UPDATE
  static const String appUpdate = "app_config.php";
  static const String razorPayConfig = "razorpay_config.php";

  ///AUTHENTICATION
  static const String createUser = "create_user.php";
  static const String login = "login_check.php";
  static const String newRegister = "new_register_otp.php";

  ///HOME TAB
  static const String getDashboardData = "get_dashboard_data.php";

  ///TRANSACTION TAB
  static const String transaction = "transaction.php";

  ///WITHDRAWAL TAB
  static const String getWithdrawalList = "withdrawal_manage.php";

  ///REFERRAL
  static const String referralCode = "referral_code.php";

  ///PROFILE
  static const String profile = "profile_manage.php";

  ///BANK
  static const String bankManage = "bank_manage.php";
  static const String getBankNameLogo = "get_bank_name_logo.php";

  ///KYC
  static const String updateKYC = "update_kyc.php";
  static const String kycStatus = "kyc_status.php";

  ///INVESTMENT
  static const String investmentManage = "investment_manage.php";

  ///PAYMENT
  static const String paymentSuccess = "payment_success.php";
  static const String paymentFailed = "payment_failed.php";
}
