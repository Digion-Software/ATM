import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/models/bank/bank_model.dart';
import 'package:atm/models/bank/get_bank_name_logo_model.dart';
import 'package:atm/repository/bank_repository.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:flutter/material.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({Key? key, required this.onAddBank, required this.isForEdit, this.bankModel})
      : super(key: key);

  final Function(bool) onAddBank;
  final bool isForEdit;
  final BankDatum? bankModel;

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController confirmAccountNumberController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  GetBankNameLogoModel? getBankNameLogoModel;
  String? bank;

  List<String>? bankName;

  @override
  void initState() {
    setData();
    setBankNameData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: widget.isForEdit ? "Edit Bank Account" : "Add Bank Account",
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bank Name",
                style: AppTextStyle.descriptionTextStyle
                    .copyWith(color: AppColors.blackColor.withOpacity(0.5), fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              bankName != null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.whiteColor,
                        border: Border.all(color: AppColors.primaryColor.withOpacity(0.1), width: 2),
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                          value: bank,
                          focusColor: AppColors.redColor,
                          underline: Container(),
                          isExpanded: true,
                          hint: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('\t\tSelect bank'),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: bankName!.map((e) {
                            return DropdownMenuItem(
                              value: e.toString(),
                              child: Text(
                                "\t\t\t$e",
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          selectedItemBuilder: (BuildContext context) => bankName!
                              .map(
                                (e) => Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "\t\t\t$e",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              bank = newValue!;
                            });
                          },
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
              CommonTextField(
                title: "Account Holder Name",
                hintText: "Enter holder name",
                controller: accountHolderNameController,
                iconChild: const SizedBox(),
                isObscure: false,
              ),
              const SizedBox(height: 20),
              CommonTextField(
                title: "Account Number",
                hintText: "Enter Account Number",
                controller: accountNumberController,
                keyBoardType: TextInputType.number,
                iconChild: const SizedBox(),
                isObscure: false,
              ),
              const SizedBox(height: 20),
              CommonTextField(
                title: "Confirm Account Number",
                hintText: "Re-Enter Account Number",
                controller: confirmAccountNumberController,
                keyBoardType: TextInputType.number,
                iconChild: const SizedBox(),
                isObscure: false,
              ),
              const SizedBox(height: 20),
              CommonTextField(
                title: "IFSC",
                hintText: "Enter IFSC number",
                controller: ifscController,
                iconChild: const SizedBox(),
                isObscure: false,
              ),
              const SizedBox(height: 50),
              ButtonView(
                title: widget.isForEdit ? "EDIT BANK":"ADD BANK",
                textColor: AppColors.whiteColor,
                onTap: () async {
                  if (widget.isForEdit) {
                    await BankRepository.editBank(
                        context: context,
                        bankId: widget.bankModel!.userBankId!,
                        bankName: bank!,
                        bankAccountName: accountHolderNameController.text,
                        bankAccountNumber: accountNumberController.text,
                        confirmBankNumber: confirmAccountNumberController.text,
                        bankIFSC: ifscController.text,
                        onAddBank: widget.onAddBank);
                  } else {
                    await BankRepository.addBank(
                        context: context,
                        bankName: bank!,
                        bankAccountName: accountHolderNameController.text,
                        bankAccountNumber: accountNumberController.text,
                        confirmBankNumber: confirmAccountNumberController.text,
                        bankIFSC: ifscController.text,
                        onAddBank: widget.onAddBank);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  setData() {
    if (widget.isForEdit) {
      bank = widget.bankModel!.bankName!;
      accountHolderNameController.text = widget.bankModel!.bankAccountHolderName!;
      accountNumberController.text = widget.bankModel!.bankAccountNumber!;
      confirmAccountNumberController.text = widget.bankModel!.bankAccountNumber!;
      ifscController.text = widget.bankModel!.bankIfsc!;
      changeState();
    }
  }

  setBankNameData() async {
    getBankNameLogoModel = await BankRepository.getBankNameLogo(context: context);
    bankName = getBankNameLogoModel!.bankData!.map((e) => e.bankName.toString()).toList();
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
