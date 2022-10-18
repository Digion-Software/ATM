import 'package:atm/config/app_colors.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class PlanDetailScreen extends StatefulWidget {
  const PlanDetailScreen({Key? key}) : super(key: key);

  @override
  State<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends State<PlanDetailScreen> {
  TextEditingController amountController = TextEditingController();
  String select = '';

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Moderate",
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          const SimpleTextView(data: "Get 5-15% monthly returns", textColor: AppColors.whiteColor),
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
                const Center(
                  child: SimpleTextView(
                      data: "Minimum Amount is 500",
                      fontSize: 12,
                      topPadding: 12,
                      bottomPadding: 16,
                      textAlign: TextAlign.center),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          select = '500';
                          amountController.text = select;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                            color: select == '500' ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: SimpleTextView(
                          data: '500',
                          textColor: select == '500' ? AppColors.whiteColor : AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          select = '1000';
                          amountController.text = select;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                            color: select == '1000' ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: SimpleTextView(
                          data: '1000',
                          textColor: select == '1000' ? AppColors.whiteColor : AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          select = '5000';
                          amountController.text = select;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                            color: select == '5000' ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: SimpleTextView(
                          data: '5000',
                          textColor: select == '5000' ? AppColors.whiteColor : AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
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
                const SimpleTextView(
                    data: "Moderate",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    topPadding: 20,
                    leftPadding: 20,
                    bottomPadding: 7),
                GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 5.5),
                    itemCount: 3,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      List<String> planFetures = ["No lock in period", "No risk onvolved", "Easy withdrawal"];
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
            margin: EdgeInsets.only(top: 30),
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
                  data: "Return upto 5-15% Monthly",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.blackColor.withOpacity(0.6),
                  topPadding: 20,
                  leftPadding: 20,
                  bottomPadding: 6,
                ),
                const SimpleTextView(
                    data: "\$500 - \$700",
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
          ButtonView(title: "NEXT", onTap: () {}, textColor: AppColors.whiteColor, leftMargin: 0, rightMargin: 0),
        ],
      ),
    );
  }
}
