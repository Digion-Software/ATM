import 'package:atm/config/app_colors.dart';
import 'package:atm/models/payments/payment_methods_model.dart';
import 'package:atm/repository/payment_repository.dart';
import 'package:atm/screens/payments/crypto_methods_screen.dart';
import 'package:atm/screens/payments/payment_proof_upload_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/type_strings.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/network_image_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class PaymentsMethodsScreen extends StatefulWidget {
  const PaymentsMethodsScreen({Key? key, required this.amount, required this.planId}) : super(key: key);

  final double amount;
  final String planId;

  @override
  State<PaymentsMethodsScreen> createState() => _PaymentsMethodsScreenState();
}

class _PaymentsMethodsScreenState extends State<PaymentsMethodsScreen> {
  PaymentMethodsModel? paymentMethodsModel;

  @override
  void initState() {
    getPaymentMethods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: "Payment Options",
        child: paymentMethodsModel == null
            ? const Center(
                child: LoadingView(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleTextView(
                      data: "Amount :  ${getINRTypeValue(rupees: widget.amount)}",
                      textColor: AppColors.whiteColor,
                      fontSize: 16,
                      bottomPadding: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        children: List.generate(
                            paymentMethodsModel!.data.length,
                            (index) => InkWell(
                                  onTap: () {
                                    if (paymentMethodsModel!.data[index].slug.toLowerCase() == "crypto") {
                                      PageNavigator.pushPage(
                                          context: context,
                                          page: CryptoMethodsScreen(
                                            amount: widget.amount,
                                            type: paymentMethodsModel!.data[index].slug,
                                            planId: widget.planId,
                                          ));
                                    } else {
                                      PageNavigator.pushPage(
                                          context: context,
                                          page: PaymentProofUploadScreen(
                                            paymentType: paymentMethodsModel!.data[index].title,
                                            amount: widget.amount,
                                            qrCode: paymentMethodsModel!.data[index].qrCode,
                                            upiId: paymentMethodsModel!.data[index].upiId,
                                            type: paymentMethodsModel!.data[index].slug,
                                            planId: widget.planId,
                                          ));
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.primaryColor.withOpacity(0.3),
                                              blurRadius: 10,
                                              spreadRadius: 2)
                                        ],
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(200),
                                          child: networkImageView(paymentMethodsModel!.data[index].imageUrl,
                                              height: 32, width: 32, boxFit: BoxFit.cover),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TitleTextView(
                                            data: paymentMethodsModel!.data[index].title,
                                            fontSize: 18,
                                            textColor: AppColors.blackColor,
                                          ),
                                        ),
                                        Icon(
                                          Icons.navigate_next,
                                          color: AppColors.greyColor.withOpacity(0.4),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ),
                ],
              ));
  }

  void getPaymentMethods() async {
    paymentMethodsModel = await PaymentRepository.getDepositMethods(context: context);
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
