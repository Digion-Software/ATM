import 'dart:io';

import 'package:atm/config/app_colors.dart';
import 'package:atm/models/app_update/razorpay_config_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/investment_repository.dart';
import 'package:atm/utils/common/show_logs.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDepositProofScreen extends StatefulWidget {
  const AddDepositProofScreen({
    Key? key,
    required this.withdrawalDatum,
    required this.razorPayConfigModel,
    required this.amount,
  }) : super(key: key);

  final WithdrawalDatum? withdrawalDatum;
  final RazorPayConfigModel razorPayConfigModel;
  final String amount;

  @override
  State<AddDepositProofScreen> createState() => _AddDepositProofScreenState();
}

class _AddDepositProofScreenState extends State<AddDepositProofScreen> {
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
      title: widget.withdrawalDatum!.planName ?? "--",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: SimpleTextView(
                data:
                    "Get ${widget.withdrawalDatum!.planMonthlyMinReturn}-${widget.withdrawalDatum!.planMonthlyMaxReturn}% monthly returns",
                textColor: AppColors.whiteColor,
                textAlign: TextAlign.left),
          ),
          const SizedBox(height: 15),
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
                widget.razorPayConfigModel.data.upiQrcode,
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
              data: widget.razorPayConfigModel.data.upiId.isEmpty
                  ? "-- UPI ID -- "
                  : widget.razorPayConfigModel.data.upiId,
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
              if (proofPicture != null) {
                await InvestRepository.investmentManualManage(
                    context: context,
                    amount: widget.amount,
                    image: proofPicture!,
                    planId: widget.withdrawalDatum!.planId ?? "1");
              } else {
                showToast(context: context, msg: "Please select screen shot for proof!", isError: true);
              }
            },
            topMargin: 30,
            leftMargin: MediaQuery.of(context).size.width / 10,
            rightMargin: MediaQuery.of(context).size.width / 10,
            textColor: AppColors.whiteColor,
            title: "SUBMIT",
          ),
        ],
      ),
    );
  }
}
