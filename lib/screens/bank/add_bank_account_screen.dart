import 'package:atm/config/app_colors.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:flutter/material.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({Key? key}) : super(key: key);

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController confirmAccountNumberController = TextEditingController();
  TextEditingController ifscController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Add Bank Account",
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 110),
            CommonTextField(
              title: "Account Holder Name",
              hintText: "Vikas",
              controller: accountHolderNameController,
              iconChild: const SizedBox(),
              isObscure: false,
            ),
            const SizedBox(height: 20),
            CommonTextField(
              title: "Account Number",
              hintText: "",
              controller: accountNumberController,
              iconChild: const SizedBox(),
              isObscure: false,
            ),
            const SizedBox(height: 20),
            CommonTextField(
              title: "Confirm Account Number",
              hintText: "",
              controller: confirmAccountNumberController,
              iconChild: const SizedBox(),
              isObscure: false,
            ),
            const SizedBox(height: 20),
            CommonTextField(
              title: "IFSC",
              hintText: "",
              controller: ifscController,
              iconChild: const SizedBox(),
              isObscure: false,
            ),
            const SizedBox(height: 50),
            ButtonView(
              title: "ADD BANK",
              textColor: AppColors.whiteColor,
              onTap: () {
                PageNavigator.pop(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
