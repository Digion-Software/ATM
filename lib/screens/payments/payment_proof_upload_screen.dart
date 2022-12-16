import 'dart:io';

import 'package:atm/config/app_colors.dart';
import 'package:atm/repository/investment_repository.dart';
import 'package:atm/utils/common/show_logs.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaymentProofUploadScreen extends StatefulWidget {
  const PaymentProofUploadScreen({
    Key? key,
    required this.paymentType,
    required this.planId,
    required this.amount,
    required this.qrCode,
    required this.upiId,
    required this.type,
  }) : super(key: key);

  final double amount;
  final String paymentType;
  final String qrCode;
  final String upiId;
  final String type;
  final String planId;

  @override
  State<PaymentProofUploadScreen> createState() => _PaymentProofUploadScreenState();
}

class _PaymentProofUploadScreenState extends State<PaymentProofUploadScreen> {
  String select = '';
  File? proofPicture;

  Future<void> uploadProofImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      proofPicture = File(image.path);
      showLogs(message: "USER PICTURE :: $proofPicture");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: widget.paymentType,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 10,
                        offset: const Offset(0, 0),
                        color: AppColors.primaryColor.withOpacity(0.3))
                  ]),
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.qrCode,
                  height: MediaQuery.of(context).size.width / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.fill,
                  colorBlendMode: BlendMode.difference,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor.withOpacity(0.2),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: DescriptionTextView(
                data: widget.upiId.isEmpty ? "-- UPI ID -- " : widget.upiId,
                textColor: AppColors.primaryColor,
                topPadding: 15,
                bottomPadding: 15,
              ),
            ),
            InkWell(
              onTap: uploadProofImage,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width / 6.5,
                  horizontal: MediaQuery.of(context).size.width / 6.5,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 1.0,
                  ),
                  image: proofPicture != null
                      ? DecorationImage(
                          image: FileImage(proofPicture!),
                        )
                      : null,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.camera_enhance_outlined,
                      size: 40,
                      color: AppColors.primaryColor,
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const DescriptionTextView(
                          data: "Upload Proof",
                          textColor: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ))
                  ],
                ),
              ),
            ),
            ButtonView(
              onTap: () async {
                if (proofPicture == null) {
                  showToast(context: context, msg: "Please select screen shot for proof!", isError: true);
                } else {
                  await InvestRepository.investmentUPIManage(
                      context: context,
                      amount: widget.amount.toString(),
                      image: proofPicture!,
                      planId: widget.planId,
                      depositMethod: widget.type);
                }
              },
              topMargin: 30,
              leftMargin: MediaQuery.of(context).size.width / 10,
              rightMargin: MediaQuery.of(context).size.width / 10,
              textColor: AppColors.whiteColor,
              title: "SUBMIT",
            ),
          ],
        ));
  }
}
