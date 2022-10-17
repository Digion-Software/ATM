import 'package:atm/config/app_colors.dart';
import 'package:atm/screens/kyc/kyc_status_screen.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class KYCScreen extends StatefulWidget {
  const KYCScreen({Key? key}) : super(key: key);

  @override
  State<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "KYC",
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SimpleTextView(data: "Choose Document Type", fontSize: 16, fontWeight: FontWeight.w500),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: const [
                              Icon(Icons.radio_button_checked, color: AppColors.primaryColor),
                              SizedBox(width: 10),
                              SimpleTextView(data: "Aadhar Card"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: const [
                              Icon(Icons.radio_button_off, color: AppColors.primaryColor),
                              SizedBox(width: 10),
                              SimpleTextView(data: "Pan Card"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SimpleTextView(data: "Upload ID Proof", fontSize: 16, fontWeight: FontWeight.w500),
                    const SizedBox(height: 15),
                    const SimpleTextView(
                        data: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.camera_alt_outlined, size: 40, color: AppColors.primaryColor),
                                SimpleTextView(data: "Front"),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.camera_alt_outlined, size: 40, color: AppColors.primaryColor),
                                SimpleTextView(data: "Back"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width / 2),
            ButtonView(
              title: "SUBMIT",
              textColor: AppColors.whiteColor,
              onTap: () {
                PageNavigator.pushPage(context: context, page: const KYCStatusScreen());
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
