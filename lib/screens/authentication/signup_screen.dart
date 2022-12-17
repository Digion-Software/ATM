import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_constant.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/models/authentication/countries_model.dart';
import 'package:atm/repository/auth_repository.dart';
import 'package:atm/utils/common/location_service.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/navigation/page_navigator.dart';
import 'package:atm/widgets/authentication/authentication_view.dart';
import 'package:atm/widgets/common/button_view.dart';
import 'package:atm/widgets/common/text_field_view.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // TextEditingController firstNameController = TextEditingController();
  // TextEditingController lastNameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

  CountriesModel? countriesModel;
  String? userCountry;

  @override
  void initState() {
    getCountriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Image.asset(
                AppImages.appLogo,
                height: 120,
                width: 120,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: AuthenticationView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleTextView(data: "Sign up", fontSize: 28),
                  SimpleTextView(
                      data: "Create an account to continue!",
                      textColor: AppColors.blackColor.withOpacity(0.5),
                      topPadding: 10,
                      fontSize: 16),
                  const SizedBox(height: 30),
                  Text(
                    "Country",
                    style: AppTextStyle.descriptionTextStyle
                        .copyWith(color: AppColors.blackColor.withOpacity(0.5), fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  countriesModel == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomSearchableDropDown(
                          items: countriesModel!.data.map((e) {
                            return "+${e.phonecode} ${e.nicename}";
                          }).toList(),
                          label: 'Select Your Country',
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.whiteColor,
                            border: Border.all(color: AppColors.primaryColor.withOpacity(0.1), width: 2),
                          ),
                          dropDownMenuItems: countriesModel!.data.map((e) {
                            return "+${e.phonecode} ${e.nicename}";
                          }).toList(),
                          hint: "Select your country",
                          onChanged: (value) {
                            userCountry = value!;
                          },
                        ),
                  // countriesModel != null
                  //     ? Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: AppColors.whiteColor,
                  //           border: Border.all(color: AppColors.primaryColor.withOpacity(0.1), width: 2),
                  //         ),
                  //         child: Center(
                  //           child: DropdownButton<String>(
                  //             value: userCountry,
                  //             focusColor: AppColors.redColor,
                  //             underline: Container(),
                  //             isExpanded: true,
                  //             hint: const Align(
                  //               alignment: Alignment.centerLeft,
                  //               child: Text('\t\tSelect Your Country'),
                  //             ),
                  //             icon: const Icon(Icons.keyboard_arrow_down),
                  //             items: countriesModel!.data.map((e) {
                  //               return DropdownMenuItem(
                  //                 value: e.nicename.toString(),
                  //                 child: Text(
                  //                   "\t\t\t+${e.phonecode} ${e.nicename}",
                  //                   style: const TextStyle(color: Colors.black),
                  //                 ),
                  //               );
                  //             }).toList(),
                  //             selectedItemBuilder: (BuildContext context) => countriesModel!.data
                  //                 .map(
                  //                   (e) => Align(
                  //                     alignment: Alignment.centerLeft,
                  //                     child: Text(
                  //                       "\t\t\t+${e.phonecode} ${e.nicename}",
                  //                       style: const TextStyle(color: Colors.black),
                  //                     ),
                  //                   ),
                  //                 )
                  //                 .toList(),
                  //             onChanged: (newValue) {
                  //               setState(() {
                  //                 userCountry = newValue!;
                  //               });
                  //             },
                  //           ),
                  //         ),
                  //       )
                  //     : const LoadingView(),

                  // CommonTextField(
                  //   title: "First Name",
                  //   hintText: "Enter First Name",
                  //   controller: firstNameController,
                  //   iconChild: const SizedBox(),
                  //   isObscure: false,
                  // ),
                  // const SizedBox(height: 20),
                  // CommonTextField(
                  //   title: "Last Name",
                  //   hintText: "Enter Last Name",
                  //   controller: lastNameController,
                  //   iconChild: const SizedBox(),
                  //   isObscure: false,
                  // ),
                  // const SizedBox(height: 20),
                  // CommonTextField(
                  //   title: "Email",
                  //   hintText: "Enter Email",
                  //   controller: emailController,
                  //   iconChild: const SizedBox(),
                  //   isObscure: false,
                  // ),
                  const SizedBox(height: 20),
                  CommonTextField(
                    title: "Phone",
                    hintText: "Enter Phone Number",
                    controller: phoneController,
                    keyBoardType: TextInputType.number,
                    iconChild: const SizedBox(),
                    isObscure: false,
                  ),
                  const SizedBox(height: 20),
                  CommonTextField(
                    title: "Referral Code",
                    hintText: "Enter Referral Code",
                    controller: referralCodeController,
                    keyBoardType: TextInputType.number,
                    iconChild: const SizedBox(),
                    isObscure: false,
                  ),
                  const SizedBox(height: 20),
                  ButtonView(
                    title: "GET VERIFICATION CODE",
                    textColor: AppColors.whiteColor,
                    onTap: () async {
                      await AuthRepository.validateAndGetOTPForNewRegister(
                          context: context,
                          userCountry: userCountry,
                          userPhone: phoneController.text,
                          referralCode: referralCodeController.text,
                          isNeedNavigation: true);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimpleTextView(
                          data: "You Already have an account?",
                          textColor: AppColors.blackColor.withOpacity(0.5),
                          fontSize: 16),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          PageNavigator.pop(context: context);
                        },
                        child: const SimpleTextView(
                            data: "Sign In",
                            textColor: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getCountriesData() async {
    getAndSetDeviceId();
    getAndSetCurrentLocation();
    countriesModel = await AuthRepository.getCounties(context: context);
    changeState();
  }

  void getAndSetDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final BaseDeviceInfo deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    allInfo.forEach((key, value) {
      if (key.toLowerCase() == "id") {
        LocalStorage.setString(key: AppConstant.deviceId, value: value);
      }
    });
  }

  void getAndSetCurrentLocation() async {
    Position position = await determinePosition();
    LocalStorage.setDouble(key: AppConstant.latitude, value: position.latitude);
    LocalStorage.setDouble(key: AppConstant.longitude, value: position.longitude);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      LocalStorage.setString(key: AppConstant.deviceCity, value: placemarks.first.locality ?? "");
      LocalStorage.setString(key: AppConstant.deviceState, value: placemarks.first.administrativeArea ?? "");
      LocalStorage.setString(key: AppConstant.deviceCountry, value: placemarks.first.country ?? "");
    }
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
  }
}
