import 'package:atm/config/app_colors.dart';
import 'package:atm/models/bank/bank_model.dart';
import 'package:atm/repository/bank_repository.dart';
import 'package:atm/screens/bank/add_bank_account_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/bank/bank_box_view.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({Key? key}) : super(key: key);

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  BankModel? bankModel;

  @override
  void initState() {
    getBankList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Bank Account",
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: bankModel == null
                  ? const Center(
                      child: LoadingView(),
                    )
                  : bankModel!.data!.isEmpty
                      ? const Center(
                          child: TitleTextView(
                            data: "No banks found!",
                            fontSize: 18,
                            textColor: AppColors.redColor,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: bankModel!.data!.length,
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: BankBoxView(
                                data: bankModel!.data![index],
                                onEditPressed: () {
                                  PageNavigator.pushPage(
                                      context: context,
                                      page: AddBankAccountScreen(
                                        isForEdit: true,
                                        bankModel: bankModel!.data![index],
                                        onAddBank: (v) {
                                          if (v) {
                                            getBankList();
                                            PageNavigator.pop(context: context);
                                          }
                                        },
                                      ));
                                },
                                onDeletePressed: () async {
                                  await BankRepository.deleteBank(
                                      context: context,
                                      bankId: bankModel!.data![index].userBankId!,
                                      onDelete: (v) async {
                                        if (v) {
                                          await getBankList();
                                        }
                                      });
                                },
                              ),
                            );
                          },
                        ),
            ),
            const SizedBox(height: 30),
            ButtonView(
              title: "ADD BANK ACCOUNT",
              textColor: AppColors.whiteColor,
              onTap: () {
                PageNavigator.pushPage(
                    context: context,
                    page: AddBankAccountScreen(
                      isForEdit: false,
                      onAddBank: (v) {
                        Navigator.pop(context);
                        getBankList();
                      },
                      bankModel: null,
                    ));
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> getBankList() async {
    bankModel = await BankRepository.getBankList(context: context);
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
