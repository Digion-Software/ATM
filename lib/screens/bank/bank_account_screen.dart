import 'package:atm/config/app_colors.dart';
import 'package:atm/screens/bank/add_bank_account_screen.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/bank/bank_box_view.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:flutter/material.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({Key? key}) : super(key: key);

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Bank Account",
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: BankBoxView(),
                );
              },
            ),
            const SizedBox(height: 30),
            ButtonView(
              title: "ADD BANK ACCOUNT",
              textColor: AppColors.whiteColor,
              onTap: () {
                PageNavigator.pushPage(context: context, page: const AddBankAccountScreen());
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
