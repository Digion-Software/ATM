class APIEndpoints {
  APIEndpoints._();

  static const String baseUrl = "http://anytimemoney.cash/";
  // static const String baseUrl = "https://atm.alphapixclients.com/";
  static const String hostUrl1 = "ajaxfiles/";
  static const String hostUrl2 = "datatable/";


  ///APP UPDATE
  static const String appConfig = "app_config.php";
  static const String razorPayConfig = "razorpay_config.php";
  static const String termsAndCondition = "http://anytimemoney.cash/terms-conditions.html";
  static const String aboutUs = "http://anytimemoney.cash/about-us.html";

  ///AUTHENTICATION
  static const String createUser = "create_user.php";
  static const String login = "login_check.php";
  static const String newRegister = "new_register_otp.php";
  static const String getCountries = "get_countries.php";

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
  static const String profileStatus = "get_user_prefrence.php";

  ///BANK
  static const String bankManage = "bank_manage.php";
  static const String getBankNameLogo = "get_bank_name_logo.php";

  ///KYC
  static const String updateKYC = "update_kyc.php";
  static const String kycStatus = "kyc_status.php";

  ///INVESTMENT
  static const String investmentManage = "investment_manage.php";
  static const String addDeposit = "add_deposit.php";

  ///PAYMENT
  static const String paymentSuccess = "payment_success.php";
  static const String paymentFailed = "payment_failed.php";

  ///FAQ AND SUPPORT
  static const String faq = "faq_details.php";
  static const String ticketList = "ticket_list.php";
  static const String commonAPI = "common_api.php";
  static const String createTicket = "customer_support.php";
  static const String viewTicketChat = "view_ticket.php";
  static const String replayTicket = "replay_ticket.php";

  ///TRANSFER PLAN
  static const String internalTransfer = "internal_transfer.php";

}
