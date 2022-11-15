import 'package:atm/config/app_colors.dart';
import 'package:atm/models/bank/bank_model.dart';
import 'package:atm/models/withdrawal/get_withdrawal_list_model.dart';
import 'package:atm/repository/bank_repository.dart';
import 'package:atm/repository/withdrawal_repository.dart';
import 'package:atm/screens/bank/add_bank_account_screen.dart';
import 'package:atm/screens/home_tab/home_screen.dart';
import 'package:atm/screens/withdraw/withdrawal_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:atm/widgets/withdrawal/withdrawal_box_view.dart';
import 'package:flutter/material.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  GetWithdrawalListModel? withdrawalListModel;

  @override
  void initState() {
    getWithdrawalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Withdraw",
      child: withdrawalListModel == null
          ? const Center(child: LoadingView())
          : withdrawalListModel!.withdrawalData!.isEmpty
              ? const Center(
                  child: TitleTextView(
                    data: "No plans found!",
                    fontSize: 18,
                    textColor: AppColors.redColor,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: withdrawalListModel!.withdrawalData!.length,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: WithdrawalBoxView(
                        data: withdrawalListModel!.withdrawalData![index],
                        onTransferPlanPressed: () {},
                        onDepositPressed: () {
                          showOptionForDeposit(
                              context: context,
                              withdrawalDatum: withdrawalListModel!.withdrawalData![index],
                              onComplete: () {
                                getWithdrawalData();
                              });
                        },
                        onWithdrawalPressed: () {
                          showOptionForWithdraw(
                            index: index,
                            context: context,
                            withdrawalDatum: withdrawalListModel!.withdrawalData![index],
                            capitalAmount:
                                double.parse((withdrawalListModel!.withdrawalData![index].invested ?? 0).toString()),
                            profitAmount:
                                double.parse((withdrawalListModel!.withdrawalData![index].profit ?? 0).toString()),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }

  Future<void> getWithdrawalData() async {
    withdrawalListModel = await WithdrawalRepository.getWithdrawalListData(context: context);
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}

void showOptionForWithdraw({
  required BuildContext context,
  required int index,
  required WithdrawalDatum withdrawalDatum,
  required double capitalAmount,
  required double profitAmount,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    elevation: 10,
    builder: (context) {
      return Container(
        decoration:
            const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: const Text(
                "Select option for withdrawal",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            InkWell(
              onTap: () {
                showOptionForBankOrUPI(
                    context: context,
                    index: index,
                    withdrawType: WithdrawType.capital_withdrawal,
                    withdrawalDatum: withdrawalDatum,
                    amount: capitalAmount);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: const [Expanded(child: Text("CAPITAL WITHDRAWAL")), Icon(Icons.arrow_forward_ios)],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showOptionForBankOrUPI(
                    context: context,
                    index: index,
                    withdrawType: WithdrawType.profit_withdrawal,
                    withdrawalDatum: withdrawalDatum,
                    amount: profitAmount);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: const [Expanded(child: Text("PROFIT WITHDRAWAL")), Icon(Icons.arrow_forward_ios)],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showOptionForBankOrUPI(
    {required BuildContext context,
    required int index,
    required double amount,
    required WithdrawType withdrawType,
    required WithdrawalDatum withdrawalDatum}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    elevation: 10,
    builder: (context) {
      return Container(
        decoration:
            const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: const Text(
                "Withdrawal to Bank or UPI",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            InkWell(
              onTap: () {
                showBankOption(
                    context: context, withdrawType: withdrawType, withdrawalDatum: withdrawalDatum, amount: amount);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: const [Expanded(child: Text("BANK")), Icon(Icons.arrow_forward_ios)],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                PageNavigator.pushPage(
                  context: context,
                  page: WithdrawalScreen(
                    withdrawType: withdrawType,
                    withdrawalDatum: withdrawalDatum,
                    bankDatum: null,
                    maxAmount: amount,
                    withdrawalTo: "upi",
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: const [Expanded(child: Text("UPI")), Icon(Icons.arrow_forward_ios)],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showBankOption(
    {required BuildContext context,
    required double amount,
    required WithdrawType withdrawType,
    required WithdrawalDatum withdrawalDatum}) async {
  BankModel? bankModel = await BankRepository.getBankList(context: context);
  if (bankModel != null) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return bankModel.data!.isEmpty
            ? Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Center(
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(59, 6, 122, 1),
                    ),
                    child: TextButton(
                      onPressed: () {
                        PageNavigator.pushPage(
                            context: context,
                            page: AddBankAccountScreen(
                                onAddBank: (v) {
                                  if (v) {
                                    print("CALL BACK FOR WITHDRAW PAGE ::");
                                    PageNavigator.pop(context: context);
                                    PageNavigator.pop(context: context);
                                    showBankOption(
                                        context: context,
                                        amount: amount,
                                        withdrawalDatum: withdrawalDatum,
                                        withdrawType: withdrawType);
                                  }
                                },
                                isForEdit: false));
                      },
                      child: const Center(
                        child: Text(
                          'Add Bank',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)), color: Colors.white),
                child: ListView.builder(
                  itemCount: bankModel.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        PageNavigator.pushPage(
                          context: context,
                          page: WithdrawalScreen(
                            withdrawType: withdrawType,
                            withdrawalDatum: withdrawalDatum,
                            bankDatum: bankModel.data![index],
                            maxAmount: amount,
                            withdrawalTo: 'bank',
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                        margin: const EdgeInsets.only(top: 18, left: 20, right: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 226, 224, 224),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              bankModel.data![index].bankLogo ?? "--",
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    bankModel.data![index].bankAccountHolderName ?? "--",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "**********${bankModel.data![index].bankAccountNumber!.replaceRange(0, 8, "")}",
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 112, 108, 108),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    bankModel.data![index].bankName ?? "--",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 112, 108, 108),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
