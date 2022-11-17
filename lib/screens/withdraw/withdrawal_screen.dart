import 'package:atm/config/app_colors.dart';
import 'package:atm/models/bank/bank_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/withdrawal_repository.dart';
import 'package:atm/utils/common/network_image_view.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/common/type_strings.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

enum WithdrawType { capital_withdrawal, profit_withdrawal }

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({
    Key? key,
    required this.withdrawType,
    required this.withdrawalDatum,
    this.bankDatum,
    required this.maxAmount,
    required this.withdrawalTo,
  }) : super(key: key);

  final WithdrawType withdrawType;
  final WithdrawalDatum withdrawalDatum;
  final BankDatum? bankDatum;
  final double maxAmount;
  final String withdrawalTo;

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  TextEditingController amountController = TextEditingController(text: "₹");
  TextEditingController upiIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Withdrawal",
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          SimpleTextView(
              data: "Your Balance: ${getINRTypeValue(rupees: widget.maxAmount)}", textColor: AppColors.whiteColor),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SimpleTextView(
                    data: "Withdrawal Amount",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    topPadding: 30,
                    leftPadding: 20,
                    bottomPadding: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.greyColor),
                      ),
                      child: const Center(child: Icon(Icons.person, color: AppColors.primaryColor)),
                    ),
                    const Icon(Icons.arrow_forward, color: AppColors.primaryColor),
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.greyColor),
                      ),
                      child: widget.withdrawalTo == "upi"
                          ? const Center(child: Icon(Icons.person, color: AppColors.primaryColor))
                          : Center(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: networkImageView(
                                    widget.bankDatum!.bankLogo ?? "",
                                    width: 50,
                                    height: 50,
                                  ))),
                    ),
                  ],
                ),
                Center(
                  child: SimpleTextView(
                      data:
                          "Withdrawing ${widget.withdrawType == WithdrawType.capital_withdrawal ? "capital" : "profit"} from Wallet",
                      topPadding: 20,
                      bottomPadding: 20,
                      textAlign: TextAlign.center),
                ),
                TextFormField(
                  controller: amountController,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  cursorHeight: 25,
                  cursorWidth: 2,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      if (int.parse(v.replaceAll("₹", "")) >= widget.maxAmount) {
                        amountController.text = "₹${widget.maxAmount.toInt().toString()}";
                        amountController.selection =
                            TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                      }
                    } else {
                      amountController.clear();
                      amountController.text = "";
                      if (v.isEmpty) {
                        amountController.text = "₹";
                        amountController.selection =
                            TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                      } else {
                        amountController.text = "₹${v.replaceAll("₹", "")}";
                        amountController.selection =
                            TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                      }
                      if (mounted) {
                        setState(() {});
                      }
                    }
                  },
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "₹",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
                widget.withdrawalTo == "upi"
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: CommonTextField(
                          title: "",
                          hintText: "UPI ID",
                          isObscure: false,
                          controller: upiIdController,
                          iconChild: const SizedBox(),
                          textAlignment: TextAlign.center,
                        ))
                    : Container(),
                const SizedBox(height: 20),
                // const Center(
                //   child: SimpleTextView(
                //       data: "Scan QR", textColor: AppColors.greyColor, bottomPadding: 20, textAlign: TextAlign.center),
                // ),
              ],
            ),
          ),
          Center(
            child: InkWell(
              onTap: () async {
                if (amountController.text.isEmpty || amountController.text == "₹") {
                  showToast(
                      context: context, msg: "Please enter amount. Amount can not be greater then your balance.", isError: true);
                } else if (amountController.text.contains(".") || amountController.text.contains("-")) {
                  showToast(context: context, msg: "Please enter valid amount", isError: true);
                } else if (widget.withdrawalTo == "upi" && upiIdController.text.isEmpty) {
                  showToast(context: context, msg: "Please enter UPI id!", isError: true);
                } else if (widget.withdrawType == WithdrawType.capital_withdrawal) {
                  await WithdrawalRepository.capitalWithdrawal(
                    context: context,
                    planId: int.parse(widget.withdrawalDatum.planId.toString()),
                    bankId: widget.withdrawalTo == "bank" ? int.parse(widget.bankDatum!.userBankId.toString()) : 0,
                    withdrawalAmount: double.parse(amountController.text.replaceAll("₹", "")),
                    paymentType: widget.withdrawalTo,
                    userUPIId: upiIdController.text,
                    accountNumber:
                        widget.withdrawalTo == "bank" ? int.parse(widget.bankDatum!.bankAccountNumber.toString()) : 0,
                  );
                } else if (widget.withdrawType == WithdrawType.profit_withdrawal) {
                  await WithdrawalRepository.profitWithdrawal(
                    context: context,
                    planId: int.parse(widget.withdrawalDatum.planId.toString()),
                    bankId: widget.withdrawalTo == "bank" ? int.parse(widget.bankDatum!.userBankId.toString()) : 0,
                    withdrawalAmount: double.parse(amountController.text.replaceAll("₹", "")),
                    paymentType: widget.withdrawalTo,
                    userUPIId: upiIdController.text,
                    accountNumber:
                        widget.withdrawalTo == "bank" ? int.parse(widget.bankDatum!.bankAccountNumber.toString()) : 0,
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
