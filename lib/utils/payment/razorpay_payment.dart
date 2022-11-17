import 'package:atm/utils/common/show_logs.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPayment {
  static final Razorpay _razorpay = Razorpay();

  static addRazorpayListeners(
      {Function(PaymentSuccessResponse)? onSuccessHandel,
      Function(PaymentFailureResponse)? onFailureHandel,
      Function(ExternalWalletResponse)? onExternalWalletHandel}) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
      if (onSuccessHandel != null) {
        showLogs(message: 'SUCCESS :: $response');
        onSuccessHandel(response);
      }
      removeRazorpayListeners();
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
      if (onFailureHandel != null) {
        showLogs(message: 'FAILED :: $response');
        onFailureHandel(response);
      }
      removeRazorpayListeners();
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) {
      if (onExternalWalletHandel != null) {
        onExternalWalletHandel(response);
      }
      removeRazorpayListeners();
    });
  }

  static removeRazorpayListeners() {
    _razorpay.clear();
  }

  static Map<String, dynamic> paymentRequestOptions = {
    'key': 'rzp_live_lvmlrllsCqpU4m',
    'amount': 100,
    'name': 'ATM',
    'description': 'Plan',
    'prefill': {'contact': '', 'email': ''}
  };

  static openRazorpayPayment() {
    _razorpay.open(paymentRequestOptions);
  }
}
