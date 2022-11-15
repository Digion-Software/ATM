import 'dart:io';

import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/models/ticket/view_ticket_chat_model.dart';
import 'package:atm/repository/ticket_repository.dart';
import 'package:atm/utils/common/show_logs.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/network_image_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomerSupportChatScreen extends StatefulWidget {
  const CustomerSupportChatScreen({Key? key, required this.ticketId}) : super(key: key);
  final String ticketId;

  @override
  State<CustomerSupportChatScreen> createState() => _CustomerSupportChatScreenState();
}

class _CustomerSupportChatScreenState extends State<CustomerSupportChatScreen> {
  TextEditingController messageController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  ViewTicketChatModel? viewTicketChatModel;
  File? attachmentPicture;

  @override
  void initState() {
    listScrollController.addListener(_scrollListener);
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
            Expanded(
              child: viewTicketChatModel != null && viewTicketChatModel!.data![0].conversation != null
                  ? ListView.builder(
                      controller: listScrollController,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: viewTicketChatModel!.data![0].conversation!.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment:
                              viewTicketChatModel!.data![0].conversation![index].position!.toLowerCase() == "right"
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.5),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                            ),
                            child: viewTicketChatModel!.data![0].conversation![index].attachment == null ||
                                    viewTicketChatModel!.data![0].conversation![index].attachment!.isEmpty
                                ? Text(viewTicketChatModel!.data![0].conversation![index].ticketconversation ?? "",
                                    style: AppTextStyle.simpleTextStyle.copyWith(color: AppColors.whiteColor))
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      networkImageView(
                                        viewTicketChatModel!.data![0].conversation![index].attachment,
                                        height: MediaQuery.of(context).size.width / 2,
                                        width: MediaQuery.of(context).size.width / 2,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(viewTicketChatModel!.data![0].conversation![index].ticketconversation ?? "",
                                          style: AppTextStyle.simpleTextStyle.copyWith(color: AppColors.whiteColor)),
                                    ],
                                  ),
                          ),
                        );
                      },
                    )
                  : Container(),
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
                  InkWell(
                    onTap: () {
                      selectAttachment();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        shape: BoxShape.circle,
                        image: attachmentPicture != null
                            ? DecorationImage(
                                image: FileImage(attachmentPicture!),
                              )
                            : null,
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.attach_file_outlined,
                        color: AppColors.whiteColor,
                      )),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: messageController,
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
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      if (messageController.text.isNotEmpty) {
                        TicketRepository.replayTicket(
                            context: context,
                            ticketChatId: widget.ticketId,
                            ticketTitle: viewTicketChatModel!.data![0].tickettitle ?? "",
                            subject: viewTicketChatModel!.data![0].subject ?? "",
                            ticketBody: messageController.text,
                            attachment: attachmentPicture,
                            onSuccess: (v) {
                              getTicketChat();
                              messageController.clear();
                            });
                      } else {}
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                      child: const Center(
                          child: Icon(
                        Icons.send,
                        color: AppColors.whiteColor,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void getTicketChat() async {
    viewTicketChatModel = await TicketRepository.viewTicketChat(context: context, ticketId: widget.ticketId);
    changeState();
  }

  Future<void> selectAttachment() async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      attachmentPicture = File(image.path);
      showLogs(message: "ATTACHMENT PICTURE :: $attachmentPicture");
    }
    setState(() {});
  }

  _scrollListener() {
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {});
    }
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
