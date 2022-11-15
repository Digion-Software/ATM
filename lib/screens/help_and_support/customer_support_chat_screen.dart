import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/models/ticket/view_ticket_chat_model.dart';
import 'package:atm/repository/ticket_repository.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:flutter/material.dart';

class CustomerSupportChatScreen extends StatefulWidget {
  const CustomerSupportChatScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSupportChatScreen> createState() => _CustomerSupportChatScreenState();
}

class _CustomerSupportChatScreenState extends State<CustomerSupportChatScreen> {
  ViewTicketChatModel? viewTicketChatModel;
  @override
  void initState() {
    getTicketChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: "Chat Screen",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...List.generate(
              3,
              (index) => Align(
                alignment: Alignment.centerRight,
                child: Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15), topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                  ),
                  child: Text("Hello", style: AppTextStyle.simpleTextStyle.copyWith(color: AppColors.whiteColor)),
                ),
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColors.greyColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: AppTextStyle.simpleTextStyle
                          .copyWith(fontSize: 16, color: AppColors.blackColor, fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: 'Type...',
                        hintStyle: AppTextStyle.simpleTextStyle
                            .copyWith(fontSize: 16, color: AppColors.greyColor, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                    child: const Center(
                        child: Icon(
                      Icons.send,
                      color: AppColors.whiteColor,
                    )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void getTicketChat() async {
    viewTicketChatModel = await TicketRepository.viewTicketChat(context: context);
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
