import 'dart:io';

import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/repository/kyc_repository.dart';
import 'package:atm/utils/common/show_logs.dart';
import 'package:atm/utils/common/show_snack_bar.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class KYCScreen extends StatefulWidget {
  const KYCScreen({Key? key, required this.isEditable}) : super(key: key);

  final bool isEditable;

  @override
  State<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  int _value = 1;
  File? fontPicture;
  File? backPicture;
  final TextEditingController documentNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "KYC",
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    offset: const Offset(0, 3),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SimpleTextView(
                        data: "Choose Document Type", fontSize: 16, fontWeight: FontWeight.w500, bottomPadding: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                  activeColor: AppColors.primaryColor,
                                  value: 1,
                                  groupValue: _value,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (value) {
                                    if (widget.isEditable) {
                                      setState(() {
                                        _value = value as int;
                                      });
                                    }
                                  }),
                              const SimpleTextView(data: "Aadhar Card"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                activeColor: AppColors.primaryColor,
                                value: 2,
                                groupValue: _value,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onChanged: (value) {
                                  if (widget.isEditable) {
                                    setState(
                                      () {
                                        _value = value as int;
                                      },
                                    );
                                  }
                                },
                              ),
                              const SimpleTextView(data: "Pan Card"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    offset: const Offset(0, 3),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: CommonTextField(
                    title: _value == 1 ? "Aadhar Card Number" : "Pan Card Number",
                    hintText: _value == 1 ? "Enter Aadhar Card Number" : "Enter Pan Card Number",
                    isObscure: false,
                    isReadOnly: !widget.isEditable,
                    controller: documentNumberController,
                    iconChild: const SizedBox()),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    offset: const Offset(0, 3),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SimpleTextView(data: "Upload ID Proof", fontSize: 16, fontWeight: FontWeight.w500),
                    const SizedBox(height: 15),
                    const SimpleTextView(
                        data: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                if (widget.isEditable) {
                                  selectFontImage();
                                }
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.width / 3,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                    color: AppColors.primaryColor.withOpacity(0.1),
                                    width: 2,
                                  ),
                                  image: fontPicture != null
                                      ? DecorationImage(
                                          image: FileImage(fontPicture!),
                                        )
                                      : null,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.camera_alt_outlined, size: 40, color: AppColors.primaryColor),
                                    SimpleTextView(data: "Front", fontSize: 16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        _value == 2
                            ? Container()
                            : Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (widget.isEditable) {
                                      selectBackImage();
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.width / 3,
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                        color: AppColors.primaryColor.withOpacity(0.1),
                                        width: 2,
                                      ),
                                      image: backPicture != null
                                          ? DecorationImage(
                                              image: FileImage(backPicture!),
                                            )
                                          : null,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.camera_alt_outlined, size: 40, color: AppColors.primaryColor),
                                        SimpleTextView(data: "Back", fontSize: 16),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ButtonView(
              title: "SUBMIT",
              textColor: AppColors.whiteColor,
              onTap: () async {
                if (widget.isEditable) {
                  if (_value == 0) {
                    showToast(context: context, msg: "Please select document type.", isError: true);
                  } else if (documentNumberController.text.isEmpty) {
                    showToast(context: context, msg: "Please enter valid document number.", isError: true);
                  } else if (_value == 1 && fontPicture == null) {
                    showToast(context: context, msg: "Please select aadhar card font image.", isError: true);
                  } else if (_value == 1 && backPicture == null) {
                    showToast(context: context, msg: "Please select aadhar card back image.", isError: true);
                  } else if (_value == 2 && fontPicture == null) {
                    showToast(context: context, msg: "Please select pan card image.", isError: true);
                  } else {
                    await KYCRepository.updateKYC(
                      isPanCard: _value == 2,
                      context: context,
                      aadharCardNumber: documentNumberController.text,
                      aadharCardFontImage: fontPicture,
                      aadharCardBackImage: backPicture,
                      panCardImage: fontPicture,
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> selectFontImage() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              color: AppColors.transparentColor,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.whiteColor),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Select image from",
                        style: AppTextStyle.buttonTextStyle.copyWith(fontSize: 18, color: AppColors.primaryColor)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            PageNavigator.pop(context: context);
                            ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: ImageSource.camera);
                            if (image != null) {
                              fontPicture = File(image.path);
                              showLogs(message: "USER PICTURE :: $fontPicture");
                            }
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.primaryColor.withOpacity(0.2)),
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              children: [
                                const Icon(Icons.camera, size: 40),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("CAMERA",
                                    style: AppTextStyle.buttonTextStyle
                                        .copyWith(fontSize: 16, color: AppColors.primaryColor)),
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(width: 15),
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            PageNavigator.pop(context: context);
                            ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              fontPicture = File(image.path);
                              showLogs(message: "USER PICTURE :: $fontPicture");
                            }
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.primaryColor.withOpacity(0.2)),
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              children: [
                                const Icon(Icons.image, size: 40),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("GALLERY",
                                    style: AppTextStyle.buttonTextStyle
                                        .copyWith(fontSize: 16, color: AppColors.primaryColor)),
                              ],
                            ),
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> selectBackImage() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              color: AppColors.transparentColor,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.whiteColor),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Select image from",
                        style: AppTextStyle.buttonTextStyle.copyWith(fontSize: 18, color: AppColors.primaryColor)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            PageNavigator.pop(context: context);
                            ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: ImageSource.camera);
                            if (image != null) {
                              backPicture = File(image.path);
                              showLogs(message: "USER PICTURE :: $backPicture");
                            }
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.primaryColor.withOpacity(0.2)),
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              children: [
                                const Icon(Icons.camera, size: 40),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("CAMERA",
                                    style: AppTextStyle.buttonTextStyle
                                        .copyWith(fontSize: 16, color: AppColors.primaryColor)),
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(width: 15),
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            PageNavigator.pop(context: context);
                            ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              backPicture = File(image.path);
                              showLogs(message: "USER PICTURE :: $backPicture");
                            }
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.primaryColor.withOpacity(0.2)),
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              children: [
                                const Icon(Icons.image, size: 40),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("GALLERY",
                                    style: AppTextStyle.buttonTextStyle
                                        .copyWith(fontSize: 16, color: AppColors.primaryColor)),
                              ],
                            ),
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
