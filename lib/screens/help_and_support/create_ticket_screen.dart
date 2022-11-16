import 'dart:io';

import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/models/ticket/ticket_option_model.dart';
import 'package:atm/repository/ticket_repository.dart';
import 'package:atm/utils/common/show_logs.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({Key? key}) : super(key: key);

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  TextEditingController ticketTitleController = TextEditingController();
  TextEditingController ticketDescriptionController = TextEditingController();
  TicketOptionModel? ticketOptionModel;
  String? optionValue;
  File? attachmentPicture;

  void getTicketOption() async {
    ticketOptionModel = await TicketRepository.getTicketOption(context: context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getTicketOption();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Create Ticket",
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextField(
              title: "Ticket Title",
              hintText: "Ticket Title",
              controller: ticketTitleController,
              iconChild: const SizedBox(),
              isObscure: false,
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Category",
                  style: AppTextStyle.descriptionTextStyle
                      .copyWith(color: AppColors.blackColor.withOpacity(0.5), fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                  child: ticketOptionModel == null
                      ? Container()
                      : DropdownButton(
                          value: optionValue,
                          isExpanded: true,
                          hint: Text("\t\t\tSelect Category",
                              style: AppTextStyle.simpleTextStyle.copyWith(
                                fontSize: 16,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400,
                              )),
                          underline: Container(),
                          items: ticketOptionModel!.data!.map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text("\t\t\t${items.toString()}",
                                  style: AppTextStyle.simpleTextStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w400,
                                  )),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              optionValue = newValue!;
                            });
                          },
                        ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            CommonTextField(
              title: "Description",
              hintText: "Description",
              controller: ticketDescriptionController,
              iconChild: const SizedBox(),
              isObscure: false,
            ),
            const SizedBox(
              height: 15,
            ),
            Text("Submit an attachment", style: AppTextStyle.descriptionTextStyle),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                selectAttachment();
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    width: 2,
                  ),
                  image: attachmentPicture != null
                      ? DecorationImage(
                          image: FileImage(attachmentPicture!),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    const Icon(Icons.upload_file_outlined, color: AppColors.primaryColor),
                    const SizedBox(width: 10),
                    Text(
                      "UPLOAD",
                      style: AppTextStyle.simpleTextStyle.copyWith(color: AppColors.primaryColor),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ButtonView(
              title: "Save",
              textColor: AppColors.whiteColor,
              onTap: () {
                TicketRepository.createTicket(
                    context: context,
                    ticketTitle: ticketTitleController.text,
                    subject: optionValue,
                    ticketBody: ticketDescriptionController.text,
                    attachment: attachmentPicture);
              },
            ),
          ],
        ),
      ),
    );
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
}
