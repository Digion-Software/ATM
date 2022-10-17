import 'package:atm/config/app_colors.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class Step {
  Step(this.title, this.body, [this.isExpanded = false]);

  String title;
  String body;
  bool isExpanded;
}

List<Step> getSteps() {
  return [
    Step(
      'What is the difference between Moderate and Aggressive plan?',
      'For Capital withdrawal- Add Bank account details in profile section first, then click on "Investments option", then click on "withdraw" button. Your funds will be credited in your account within 24 hours. For Interest earned withdrawal- Click on "Pay Money" option on home page. Add UPI id and click on make payment. Your profit will be credited in account within 48 hours.',
    ),
    Step(
      'How can I withdraw the Principal amount and Interest earned amount?',
      'For Capital withdrawal- Add Bank account details in profile section first, then click on "Investments option", then click on "withdraw" button. Your funds will be credited in your account within 24 hours. For Interest earned withdrawal- Click on "Pay Money" option on home page. Add UPI id and click on make payment. Your profit will be credited in account within 48 hours.',
    ),
    Step(
      'I have deposited funds in costa savings account via razor pay but it not showing in "my balance". How to rectify this issue?',
      'For Capital withdrawal- Add Bank account details in profile section first, then click on "Investments option", then click on "withdraw" button. Your funds will be credited in your account within 24 hours. For Interest earned withdrawal- Click on "Pay Money" option on home page. Add UPI id and click on make payment. Your profit will be credited in account within 48 hours.',
    ),
  ];
}

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  final List<Step> _steps = getSteps();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "FAQ",
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const SimpleTextView(data: "Help & Support", textColor: AppColors.whiteColor),
            const SizedBox(height: 20),
            Container(
              child: _renderSteps(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _renderSteps() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _steps[index].isExpanded = !isExpanded;
        });
      },
      children: _steps.map<ExpansionPanel>((Step step) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              title: SimpleTextView(data: step.title, fontWeight: FontWeight.w500),
            );
          },
          body: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            title: SimpleTextView(data: step.body,textColor: AppColors.blackColor.withOpacity(0.7)),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}
