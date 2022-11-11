import 'package:atm/repository/ticket_repository.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:flutter/material.dart';

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {

  @override
  void initState() {
    getAllTicket();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(title: "Customer Support", child: Column());
  }

  void getAllTicket()async
  {
    await TicketRepository.getTicketList(context: context);
    changeState();
  }

  void changeState(){
    if(mounted){
      setState(() {

      });
    }
  }
}
