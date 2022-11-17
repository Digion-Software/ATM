import 'package:atm/config/app_colors.dart';
import 'package:atm/models/profile/profile_data_model.dart';
import 'package:atm/repository/profile_repository.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.profileDataModel, required this.isUpdated}) : super(key: key);

  final ProfileDataModel profileDataModel;
  final Function(bool) isUpdated;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? selectedGender;

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Edit Profile",
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CommonTextField(
                title: "First Name",
                hintText: "Enter First Name",
                controller: firstNameController,
                iconChild: const SizedBox(),
                isObscure: false,
              ),
              const SizedBox(height: 20),
              CommonTextField(
                title: "Last Name",
                hintText: "Enter Last Name",
                controller: lastNameController,
                iconChild: const SizedBox(),
                isObscure: false,
              ),
              const SizedBox(height: 20),
              CommonTextField(
                title: "Email",
                hintText: "Enter Your Email",
                controller: emailController,
                iconChild: const SizedBox(),
                isObscure: false,
              ),
              const SizedBox(height: 20),
              CommonTextField(
                title: "Phone",
                hintText: "Enter Phone Number",
                controller: phoneController,
                iconChild: const SizedBox(),
                isObscure: false,
                isReadOnly: true,
              ),
              const SizedBox(height: 20),
              CommonTextField(
                onTap: () async {
                  await selectDate(context: context, initialDate: DateTime.now());
                },
                title: "Date Of Birth",
                hintText: "Enter Your DOB",
                controller: dateOfBirthController,
                iconChild: const SizedBox(),
                isObscure: false,
                isReadOnly: true,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.primaryColor.withOpacity(0.1), width: 2),
                ),
                child: Center(
                  child: DropdownButton<String>(
                    value: selectedGender,
                    focusColor: AppColors.redColor,
                    underline: Container(),
                    isExpanded: true,
                    hint: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('\t\tSelect Your Gender'),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: ["Male", "Female"].map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(
                          "\t\t\t$e",
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                        genderController.text = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CommonTextField(
                title: "Address",
                hintText: "Enter Your Address",
                controller: addressController,
                iconChild: const SizedBox(),
                isObscure: false,
                maxLine: 5,
              ),
              const SizedBox(height: 20),
              ButtonView(
                title: "SAVE",
                textColor: AppColors.whiteColor,
                onTap: () async {
                  await ProfileRepository.validateAndUpdateProfileData(
                    context: context,
                    userFirstName: firstNameController.text,
                    userLastName: lastNameController.text,
                    userEmail: emailController.text,
                    userGender: genderController.text,
                    userDOB: dateOfBirthController.text,
                    userAddress: addressController.text,
                    isUpdate: widget.isUpdated,
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  setData() {
    firstNameController.text = widget.profileDataModel.data!.userFirstName ?? "";
    lastNameController.text = widget.profileDataModel.data!.userLastName ?? "";
    emailController.text = widget.profileDataModel.data!.userEmail ?? "";
    phoneController.text = widget.profileDataModel.data!.userPhone ?? "";
    genderController.text = widget.profileDataModel.data!.gender ?? "";
    if(widget.profileDataModel.data!.gender != null && widget.profileDataModel.data!.gender != "") {
      selectedGender = widget.profileDataModel.data!.gender;
    }
    dateOfBirthController.text = widget.profileDataModel.data!.userDob ?? "";
    addressController.text = widget.profileDataModel.data!.userAddress ?? "";
  }

  Future<void> selectDate({
    required BuildContext context,
    required DateTime initialDate,
  }) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (picked != null) {
      initialDate = picked;
      dateOfBirthController.text = DateFormat.yMd().format(initialDate);
    }
  }
}
