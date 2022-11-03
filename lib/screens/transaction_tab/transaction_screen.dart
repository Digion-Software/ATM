import 'package:atm/config/app_colors.dart';
import 'package:atm/models/transaction/transaction_model.dart';
import 'package:atm/repository/transaction_repository.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:atm/widgets/transaction/transaction_view.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TransactionModel? _transactionModel;

  @override
  void initState() {
    getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _transactionModel == null
        ? const Center(child: LoadingView())
        : _transactionModel!.transactionData!.isEmpty
            ? const Center(
                child: TitleTextView(
                  data: "No transactions found!",
                  fontSize: 18,
                  textColor: AppColors.redColor,
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _transactionModel!.transactionData!.length,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TransactionView(data: _transactionModel!.transactionData![index]),
                    );
                  },
                ),
              );
  }

  Future<void> getTransactions() async {
    _transactionModel = await TransactionRepository.getTransactions(context: context);
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
