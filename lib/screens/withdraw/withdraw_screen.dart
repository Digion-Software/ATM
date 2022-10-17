import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/withdrawal/withdrawal_box_view.dart';
import 'package:flutter/material.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Withdraw",
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: WithdrawalBoxView(),
          );
        },
      ),
    );
  }
}
