import 'package:atm/config/app_colors.dart';
import 'package:atm/models/app_update/razorpay_config_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/screens/deposit_tab/deposit_screen.dart';
import 'package:atm/screens/payments/payments_methods_screen.dart';
import 'package:atm/screens/plan_detail/add_deposit_proof_screen.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/common/type_strings.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class PlanDetailScreen extends StatefulWidget {
  const PlanDetailScreen(
      {Key? key, required this.depositType, required this.razorPayConfigModel, required this.withdrawalDatum})
      : super(key: key);

  final WithdrawalDatum? withdrawalDatum;
  final DepositType depositType;
  final RazorPayConfigModel razorPayConfigModel;

  @override
  State<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends State<PlanDetailScreen> {
  TextEditingController amountController = TextEditingController(text: "₹");
  String select = '';

  @override
  void initState() {
    if (widget.withdrawalDatum!.planMinimumAmount != null) {
      amountController.text = "₹${widget.withdrawalDatum!.planMinimumAmount!}";
      if (double.parse((widget.withdrawalDatum!.planMinimumAmount ?? 0).toString()) == 500) {
        select = "500";
      } else if (double.parse((widget.withdrawalDatum!.planMinimumAmount ?? 0).toString()) == 1000) {
        select = "1000";
      } else if (double.parse((widget.withdrawalDatum!.planMinimumAmount ?? 0).toString()) == 5000) {
        select = "5000";
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: widget.withdrawalDatum!.planName ?? "--",
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          SimpleTextView(
              data:
                  "Get ${widget.withdrawalDatum!.planMonthlyMinReturn}-${widget.withdrawalDatum!.planMonthlyMaxReturn}% monthly returns",
              textColor: AppColors.whiteColor),
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
                    data: "Deposit Amount", fontSize: 18, fontWeight: FontWeight.w600, topPadding: 30, leftPadding: 20),
                const SizedBox(height: 25),
                TextFormField(
                  controller: amountController,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  cursorHeight: 25,
                  cursorWidth: 2,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  onChanged: (c) {
                    amountController.clear();
                    if (c.isEmpty) {
                      amountController.text = "₹";
                      amountController.selection =
                          TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                    } else {
                      amountController.text = "₹${c.replaceAll("₹", "")}";
                      amountController.selection =
                          TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                    }
                    if (mounted) {
                      setState(() {});
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
                Center(
                  child: SimpleTextView(
                      data:
                          "Minimum Amount is ${getINRTypeValue(rupees: double.parse((widget.withdrawalDatum!.planMinimumAmount ?? "500")), decimalDigits: 0)}",
                      fontSize: 13,
                      topPadding: 12,
                      bottomPadding: 16,
                      textAlign: TextAlign.center),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    amountSelectionButton(
                      title: "500",
                      isSelected: select == "500",
                      onPressed: () {
                        setState(() {
                          select = '500';
                          amountController.text = "₹500";
                          amountController.selection =
                              TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                        });
                      },
                    ),
                    const Spacer(),
                    amountSelectionButton(
                      title: "1000",
                      isSelected: select == "1000",
                      onPressed: () {
                        setState(() {
                          select = '1000';
                          amountController.text = "₹1000";
                          amountController.selection =
                              TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                        });
                      },
                    ),
                    const Spacer(),
                    amountSelectionButton(
                      title: "5000",
                      isSelected: select == "5000",
                      onPressed: () {
                        setState(() {
                          select = '5000';
                          amountController.text = "₹5000";
                          amountController.selection =
                              TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                        });
                      },
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 40),
              ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleTextView(
                    data: widget.withdrawalDatum!.planName ?? "",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    topPadding: 20,
                    leftPadding: 20,
                    bottomPadding: 7),
                GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 5.5),
                    itemCount: widget.withdrawalDatum!.planDescription != null
                        ? widget.withdrawalDatum!.planDescription!.split("\n").length
                        : 0,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      List<String> planFetures = widget.withdrawalDatum!.planDescription != null
                          ? widget.withdrawalDatum!.planDescription!
                              .split("\n")
                              .map((e) => e.replaceFirst("-", ""))
                              .toList()
                          : [];
                      return IntrinsicHeight(
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 7,
                              color: AppColors.blackColor.withOpacity(0.65),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: SimpleTextView(
                              data: planFetures[index],
                              textColor: AppColors.blackColor.withOpacity(0.65),
                            ))
                          ],
                        ),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 30),
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
                SimpleTextView(
                  data:
                      "Return upto ${widget.withdrawalDatum!.planMonthlyMinReturn}-${widget.withdrawalDatum!.planMonthlyMaxReturn}% Monthly",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.blackColor.withOpacity(0.6),
                  topPadding: 20,
                  leftPadding: 20,
                  bottomPadding: 6,
                ),
                SimpleTextView(
                    data: amountController.text.isNotEmpty &&
                            amountController.text != "₹" &&
                            !amountController.text.contains(".") &&
                            !amountController.text.contains("-")
                        ? "${getINRTypeValue(rupees: double.parse((int.parse(amountController.text.replaceAll("₹", "")) * int.parse(widget.withdrawalDatum!.planMonthlyMinReturn ?? "0") / 100).toString()), decimalDigits: 0)} - ${getINRTypeValue(rupees: double.parse((int.parse(amountController.text.replaceAll("₹", "")) * int.parse(widget.withdrawalDatum!.planMonthlyMaxReturn ?? "0") / 100).toString()), decimalDigits: 0)}"
                        : "₹0 - ₹0",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.primaryColor,
                    leftPadding: 20,
                    bottomPadding: 15),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ButtonView(
              title: "NEXT",
              onTap: () async {
                if (widget.depositType == DepositType.manual_deposit) {
                  if (amountController.text.isEmpty || amountController.text == "₹") {
                    showToast(
                        context: context,
                        msg: "Please enter or select at least minimum amount of plan.",
                        isError: true);
                  } else if (double.parse(amountController.text.replaceAll("₹", "")) <
                      double.parse(widget.withdrawalDatum!.planMinimumAmount ?? "500")) {
                    showToast(context: context, msg: "Please fill at least minimum amount of plan.", isError: true);
                  } else if (amountController.text.replaceAll("₹", "").isNotEmpty &&
                      int.parse(amountController.text.replaceAll("₹", "")) > 0 &&
                      double.parse(amountController.text.replaceAll("₹", "")) >=
                          double.parse(widget.withdrawalDatum!.planMinimumAmount ?? "500")) {
                    PageNavigator.pushPage(
                        context: context,
                        page: AddDepositProofScreen(
                          razorPayConfigModel: widget.razorPayConfigModel,
                          amount: amountController.text.replaceAll("₹", ""),
                          withdrawalDatum: widget.withdrawalDatum,
                        ));
                  } else {
                    showToast(context: context, msg: "Please enter correct amount!", isError: true);
                  }
                } else {
                  if (amountController.text.isEmpty || amountController.text == "₹") {
                    showToast(
                        context: context,
                        msg: "Please enter or select at least minimum amount of plan.",
                        isError: true);
                  } else if (amountController.text.contains(".") || amountController.text.contains("-")) {
                    showToast(context: context, msg: "Please enter valid amount", isError: true);
                  } else if (double.parse(amountController.text.replaceAll("₹", "")) <
                      double.parse(widget.withdrawalDatum!.planMinimumAmount ?? "500")) {
                    showToast(context: context, msg: "Please fill at least minimum amount of plan.", isError: true);
                  } else if (amountController.text.replaceAll("₹", "").isNotEmpty &&
                      int.parse(amountController.text.replaceAll("₹", "")) > 0 &&
                      double.parse(amountController.text.replaceAll("₹", "")) >=
                          double.parse(widget.withdrawalDatum!.planMinimumAmount ?? "500")) {
                    PageNavigator.pushPage(
                        context: context,
                        page: PaymentsMethodsScreen(
                          amount: double.parse(amountController.text.replaceAll("₹", "")),
                          planId: widget.withdrawalDatum!.planId ?? "1",
                        ));
                    // await InvestRepository.investmentOnlineManage(
                    //   context: context,
                    //   amount: amountController.text.replaceAll("₹", ""),
                    //   planId: widget.withdrawalDatum!.planId ?? "1",
                    //   razorPayKey: widget.razorPayConfigModel.data.razorpayData.key,
                    //   razorPayConfigModel: widget.razorPayConfigModel
                    // );
                  } else {
                    showToast(context: context, msg: "Please enter correct amount!", isError: true);
                  }
                }
              },
              textColor: AppColors.whiteColor,
              leftMargin: 0,
              rightMargin: 0),
        ],
      ),
    );
  }

  SizedBox amountSelectionButton({
    required String title,
    required Function() onPressed,
    required bool isSelected,
  }) {
    return SizedBox(
      height: 45,
      width: 80,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5, right: 5),
            child: InkWell(
              onTap: onPressed,
              child: Container(
                height: 35,
                width: 70,
                decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: SimpleTextView(
                    data: title,
                    textColor: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : AppColors.transparentColor,
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? AppColors.whiteColor : AppColors.transparentColor)),
            child: Center(
                child: Icon(
              Icons.check,
              size: 12,
              color: isSelected ? AppColors.whiteColor : AppColors.transparentColor,
            )),
          ),
        ],
      ),
    );
  }
}
