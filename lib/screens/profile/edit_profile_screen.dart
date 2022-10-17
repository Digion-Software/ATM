import 'package:atm/config/app_colors.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
                hintText: "Vikas",
                controller: firstNameController,
                iconChild: const SizedBox(),
                isObscure: false,
              ),
              const SizedBox(height: 20),
              CommonTextField(
                title: "Last Name",
                hintText: "Patel",
                controller: lastNameController,
                iconChild: const SizedBox(),
                isObscure: false,
              ),
              const SizedBox(height: 20),
              CommonTextField(
                title: "Email",
                hintText: "vikaspatel@gmail.com",
                controller: emailController,
                iconChild: const SizedBox(),
                isObscure: false,
              ),
              const SizedBox(height: 20),
              CommonTextField(
                title: "Phone",
                hintText: "9999999999",
                controller: phoneController,
                iconChild: const SizedBox(),
                isObscure: false,
              ),
              const SizedBox(height: 50),
              ButtonView(
                title: "SAVE",
                textColor: AppColors.whiteColor,
                onTap: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
