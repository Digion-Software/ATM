import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/models/ticket/ticket_list_model.dart';
import 'package:atm/repository/ticket_repository.dart';
import 'package:atm/screens/help_and_support/create_ticket_screen.dart';
import 'package:atm/screens/help_and_support/customer_support_chat_screen.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/divider_view.dart';
import 'package:flutter/material.dart';

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  TicketListModel? ticketListModel;
  @override
  void initState() {
    getAllTicket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonScaffold(
        title: "Customer Support",
        child: ticketListModel != null
            ? ticketListModel!.aaData!.isEmpty
                ? Center(
                    child: Text(
                    "No ticket found yet!",
                    style: AppTextStyle.descriptionTextStyle,
                  ))
                : Column(
                    children: List.generate(
                      ticketListModel!.aaData!.length,
                      (index) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        color: AppColors.whiteColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ticketListModel!.aaData![index].ticketTitle ?? "",
                                      style: AppTextStyle.descriptionTextStyle
                                          .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      ticketListModel!.aaData![index].subject ?? "",
                                      style: AppTextStyle.descriptionTextStyle
                                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: ticketListModel!.aaData![index].status == "Open"
                                              ? AppColors.greenColor
                                              : AppColors.redColor,
                                          borderRadius: BorderRadius.circular(3)),
                                      child: Center(
                                          child: Text(
                                        ticketListModel!.aaData![index].status ?? "",
                                        style: AppTextStyle.simpleTextStyle
                                            .copyWith(fontSize: 9, color: AppColors.whiteColor),
                                      )),
                                    ),
                                    ticketListModel!.aaData![index].status == "Open"
                                        ? const SizedBox(height: 5)
                                        : Container(),
                                    ticketListModel!.aaData![index].status == "Open"
                                        ? InkWell(
                                            onTap: () {
                                              PageNavigator.pushPage(
                                                  context: context, page: const CustomerSupportChatScreen());
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius: BorderRadius.circular(3)),
                                              child: Center(
                                                  child: Text(
                                                "Chat",
                                                style: AppTextStyle.simpleTextStyle
                                                    .copyWith(fontSize: 9, color: AppColors.whiteColor),
                                              )),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              ticketListModel!.aaData![index].ticketBody ?? "",
                              style: AppTextStyle.descriptionTextStyle
                                  .copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textGreyColor),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              ticketListModel!.aaData![index].ticketDateTime ?? "",
                              style: AppTextStyle.descriptionTextStyle
                                  .copyWith(fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.textGreyColor),
                            ),
                            const SizedBox(height: 15),
                            DividerView(
                              topMargin: 0,
                              bottomMargin: 0,
                              leftMargin: 0,
                              rightMargin: 0,
                              dividerHeight: 1.5,
                              dividerColor: AppColors.primaryColor.withOpacity(0.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
            : const LoadingView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PageNavigator.pushPage(context: context, page: const CreateTicketScreen());
        },
        backgroundColor: AppColors.primaryColor,
        child: const Center(child: Icon(Icons.add)),
      ),
    );
  }

  void getAllTicket() async {
    ticketListModel = await TicketRepository.getTicketList(context: context);
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
