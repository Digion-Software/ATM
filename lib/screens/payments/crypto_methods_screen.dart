import 'package:atm/config/app_colors.dart';
import 'package:atm/models/payments/crypto_methods_model.dart';
import 'package:atm/repository/investment_repository.dart';
import 'package:atm/repository/payment_repository.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/common/type_strings.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/network_image_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class CryptoMethodsScreen extends StatefulWidget {
  const CryptoMethodsScreen({Key? key, required this.amount, required this.type, required this.planId})
      : super(key: key);

  final double amount;
  final String planId;
  final String type;

  @override
  State<CryptoMethodsScreen> createState() => _CryptoMethodsScreenState();
}

class _CryptoMethodsScreenState extends State<CryptoMethodsScreen> {
  CryptoMethodsModel? cryptoMethodsModel;

  @override
  void initState() {
    getPaymentMethods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: "Crypto Options",
        child: cryptoMethodsModel == null
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
                            cryptoMethodsModel!.data.length,
                            (index) => InkWell(
                                  onTap: () async {
                                    // PageNavigator.pushPage(
                                    //     context: context,
                                    //     page: PaymentProofUploadScreen(
                                    //       paymentType: "Crypto (${cryptoMethodsModel!.data[index].title})",
                                    //       amount: widget.amount,
                                    //       upiId: cryptoMethodsModel!.data[index].upiId,
                                    //       qrCode: cryptoMethodsModel!.data[index].qrCode,
                                    //       type: widget.type,
                                    //       planId: widget.planId,
                                    //     ));
                                    await InvestRepository.investmentCryptoManage(
                                        context: context,
                                        amount: widget.amount.toString(),
                                        cryptoType: cryptoMethodsModel!.data[index].title.toLowerCase(),
                                        planId: widget.planId,
                                        depositMethod: widget.type);
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
                                          child: networkImageView(cryptoMethodsModel!.data[index].imageUrl,
                                              height: 32, width: 32, boxFit: BoxFit.cover),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TitleTextView(
                                            data: cryptoMethodsModel!.data[index].title,
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
    cryptoMethodsModel = await PaymentRepository.getCryptoMethods(context: context);
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
