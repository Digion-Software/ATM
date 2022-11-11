import 'package:atm/config/app_colors.dart';
import 'package:atm/config/app_images.dart';
import 'package:atm/config/app_text_style.dart';
import 'package:atm/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_screen/OnbordingData.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;

  final List<OnbordingData> slides = [
    OnbordingData(
      imagePath: AppImages.introOne,
      title: "Save and Invest",
      desc: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
    ),
    OnbordingData(
      imagePath: AppImages.introTwo,
      title: "Grow Money",
      desc: "Sit back and watch your money grow Money goes into Diamond business and other statups",
    ),
    OnbordingData(
      imagePath: AppImages.introThree,
      title: "Earn Day to Day basis",
      desc: "Earn Day to Day basis and Get rewards instantly",
    ),
    OnbordingData(
      imagePath: AppImages.introFour,
      title: "Withdraw",
      desc: "Withdraw into your back account",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: slides.length,
              itemBuilder: (context, index) {
                return Slider(
                  image: slides[index].imagePath,
                  title: slides[index].title,
                  description: slides[index].desc,
                );
              }),
          Positioned(
            top: 50,
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(),
                    ),
                    (route) => false);
              },
              child: Text(
                "Skip",
                style: AppTextStyle.buttonTextStyle
                    .copyWith(color: AppColors.greyColor, fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 20,
            child: InkWell(
              onTap: () {
                if (currentIndex != 0) {
                  pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  currentIndex--;
                  if (mounted) {
                    setState(() {});
                  }
                }
              },
              child: Text(
                currentIndex == 0 ? '' : 'Back',
                style: AppTextStyle.buttonTextStyle
                    .copyWith(color: AppColors.greyColor, fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  slides.length,
                  (index) => buildDot(index, context),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            right: 20,
            child: InkWell(
              onTap: () {
                if (currentIndex == 3) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                      (route) => false);
                } else {
                  pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  currentIndex++;
                  if (mounted) {
                    setState(() {});
                  }
                }
              },
              child: Text(
                currentIndex == 3 ? 'Done' : 'Next',
                style: AppTextStyle.buttonTextStyle
                    .copyWith(color: AppColors.greyColor, fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: currentIndex == index ? 10 : 7,
      width: currentIndex == index ? 10 : 7,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index ? AppColors.primaryColor : AppColors.greyColor,
      ),
    );
  }
}

class Slider extends StatelessWidget {
  const Slider({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image(
              image: AssetImage(image),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 4,
            ),
            Text(
              title.toString(),
              textAlign: TextAlign.center,
              style: AppTextStyle.titleTextStyle.copyWith(fontSize: 28, color: const Color(0XFF212121)),
              strutStyle: const StrutStyle(
                height: 1.1,
                leading: 1.1,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              description.toString(),
              textAlign: TextAlign.center,
              style: AppTextStyle.descriptionTextStyle.copyWith(fontSize: 14, color: AppColors.textColor),
              strutStyle: const StrutStyle(
                height: 0.8,
                leading: 0.8,
              ),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
