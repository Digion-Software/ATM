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
    'key': 'rzp_test_cqWTKfyMXLgv8U',
    'amount': 50000,
    'name': 'Test',
    'description': 'Test',
    'prefill': {'contact': '9999999999', 'email': 'test@gmail.com'}
  };

  static openRazorpayPayment() {
    _razorpay.open(paymentRequestOptions);
  }
}
