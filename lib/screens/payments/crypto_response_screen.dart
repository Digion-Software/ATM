import 'package:atm/config/app_colors.dart';
import 'package:atm/models/payments/crypto_response_model.dart';
import 'package:atm/repository/investment_repository.dart';
import 'package:atm/screens/dashboard/dashboard_screen.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/divider_view.dart';
import 'package:atm/widgets/common/network_image_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CryptoResponseScreen extends StatefulWidget {
  const CryptoResponseScreen({Key? key, required this.cryptoData}) : super(key: key);

  final CryptoData cryptoData;

  @override
  State<CryptoResponseScreen> createState() => _CryptoResponseScreenState();
}

class _CryptoResponseScreenState extends State<CryptoResponseScreen> {
  CustomTimerController customTimerController = CustomTimerController();

  @override
  void initState() {
    customTimerController.start();
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: CommonScaffold(
          title: "Crypto Payment",
          onBackPressed: () {
            PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
          },
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              offset: const Offset(0, 3),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SimpleTextView(data: "Crypto\nAddress : ", textColor: AppColors.greyColor),
                                Expanded(
                                    child: ButtonTextView(
                                  data: widget.cryptoData.cryptoAddress,
                                  textColor: AppColors.primaryColor,
                                  textAlign: TextAlign.center,
                                  topPadding: 0,
                                  bottomPadding: 0,
                                )),
                                IconButton(
                                    onPressed: () async {
                                      await Clipboard.setData(ClipboardData(text: widget.cryptoData.cryptoAddress))
                                          .whenComplete(() {
                                        showToast(context: context, msg: "Crypto Address Copied!");
                                      });
                                    },
                                    icon: const Icon(Icons.copy))
                              ],
                            ),
                            const DividerView(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SimpleTextView(data: "Crypto Currency Amount : ", textColor: AppColors.greyColor),
                                Expanded(
                                    child: ButtonTextView(
                                  textAlign: TextAlign.end,
                                  data: widget.cryptoData.totalCryptoAmount,
                                  textColor: AppColors.greenColor,
                                  topPadding: 0,
                                  bottomPadding: 0,
                                )),
                              ],
                            ),
                            const DividerView(),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     const SimpleTextView(data: "Investment Id : ", textColor: AppColors.greyColor),
                            //     Expanded(
                            //         child: ButtonTextView(
                            //           data: widget.cryptoData.investmentId.toString(),
                            //           textColor: AppColors.greenColor,
                            //           textAlign: TextAlign.end,
                            //           topPadding: 0,
                            //           bottomPadding: 0,
                            //         )),
                            //   ],
                            // ),
                            // const DividerView(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SimpleTextView(data: "Transaction Id : ", textColor: AppColors.greyColor),
                                Expanded(
                                    child: ButtonTextView(
                                  data: widget.cryptoData.transactionId,
                                  textColor: AppColors.greenColor,
                                  textAlign: TextAlign.end,
                                  topPadding: 0,
                                  bottomPadding: 0,
                                )),
                              ],
                            ),
                            const DividerView(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SimpleTextView(data: "QR Code : ", textColor: AppColors.greyColor),
                                networkImageView(widget.cryptoData.qrcodeUrl,
                                    width: MediaQuery.of(context).size.width / 3,
                                    height: MediaQuery.of(context).size.width / 3),
                              ],
                            ),
                            const DividerView(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SimpleTextView(data: "totalCryptoRcvAmount : ", textColor: AppColors.greyColor),
                                Expanded(
                                    child: ButtonTextView(
                                  data: widget.cryptoData.totalCryptoRcvAmount.toString(),
                                  textColor: AppColors.greenColor,
                                  textAlign: TextAlign.end,
                                  topPadding: 0,
                                  bottomPadding: 0,
                                )),
                              ],
                            ),
                            const DividerView(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SimpleTextView(data: "Timeout in", textColor: AppColors.greyColor),
                                Expanded(
                                  child: CustomTimer(
                                      controller: customTimerController,
                                      begin: Duration(seconds: widget.cryptoData.timeout),
                                      end: const Duration(),
                                      builder: (time) {
                                        return Text(
                                            "${time.hours}:${time.minutes}:${time.seconds}",
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(fontSize: 24.0));
                                      }),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              ButtonView(
                  title: "Home",
                  bottomMargin: 15,
                  textColor: AppColors.whiteColor,
                  onTap: () {
                    PageNavigator.pushAndRemoveUntilPage(context: context, page: const DashboardScreen());
                  })
            ],
          )),
    );
  }

  checkStatus() async {
    Future.delayed(
      const Duration(seconds: 10),
      () {
        InvestRepository.checkCryptoResponse(
            context: context,
            investmentId: widget.cryptoData.investmentId.toString(),
            transactionId: widget.cryptoData.transactionId.toString());
      },
    );
  }
}
