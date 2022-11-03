import 'package:intl/intl.dart';

String getINRTypeValue({required double rupees, bool isSpaceAvailable = false, int decimalDigits = 2}) {
  return NumberFormat.currency(
    symbol: isSpaceAvailable ? '₹\t' : '₹',
    locale: "HI",
    decimalDigits: decimalDigits,
  ).format(rupees);
}
