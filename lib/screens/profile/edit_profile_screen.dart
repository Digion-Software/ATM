import 'package:atm/config/app_colors.dart';
import 'package:atm/models/profile/profile_data_model.dart';
import 'package:atm/repository/profile_repository.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key,required this.profileDataModel, required this.isUpdated}) : super(key: key);

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
                hintText: "Enter Email",
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
              ),
              const SizedBox(height: 50),
              ButtonView(
                title: "SAVE",
                textColor: AppColors.whiteColor,
                onTap: () async {
                  await ProfileRepository.validateAndUpdateProfileData(
                      context: context,
                      userFirstName: firstNameController.text,
                      userLastName: lastNameController.text,
                      isUpdate: widget.isUpdated);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  setData() {
    firstNameController.text = widget.profileDataModel.transactionData!.firstName;
    lastNameController.text = widget.profileDataModel.transactionData!.userLastName;
    emailController.text = widget.profileDataModel.transactionData!.userEmail;
    phoneController.text = widget.profileDataModel.transactionData!.userPhone.replaceAll("-", " ");
  }
}
