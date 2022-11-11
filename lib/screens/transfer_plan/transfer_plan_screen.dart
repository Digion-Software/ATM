import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:flutter/material.dart';

class TransferPlanScreen extends StatefulWidget {
  const TransferPlanScreen({Key? key}) : super(key: key);

  @override
  State<TransferPlanScreen> createState() => _TransferPlanScreenState();
}

class _TransferPlanScreenState extends State<TransferPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(title: "Transfer Plan", child: Column());
  }
}
