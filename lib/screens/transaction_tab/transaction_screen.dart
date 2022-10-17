import 'package:atm/models/transaction/transaction_model.dart';
import 'package:atm/repository/transaction_repository.dart';
import 'package:atm/utils/common/loading_view.dart';
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
    // getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _transactionModel != null
        ? const Center(child: LoadingView())
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 20 /*_transactionModel!.transactionData!.length*/,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TransactionView(data: null /*_transactionModel!.transactionData![index]*/),
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
