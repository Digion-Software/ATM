import 'package:atm/config/app_colors.dart';
import 'package:atm/models/faq/faq_model.dart';
import 'package:atm/repository/faq_repository.dart';
import 'package:atm/utils/common/loading_view.dart';
import 'package:atm/widgets/common/common_scaffold.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class Step {
  Step(this.title, this.body, [this.isExpanded = false]);

  String title;
  String body;
  bool isExpanded;
}

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  List<Step> _steps = [];
  FaqModel? faqModel;

  getFAQData() async {
    faqModel = await FAQRepository.getFAQList();
    _steps.addAll(faqModel!.data!.map((e) => Step(e.question!, e.answer!)));
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getFAQData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "FAQ",
      child: _steps.isEmpty
          ? const Center(
              child: LoadingView(),
            )
          : SingleChildScrollView(
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              title: SimpleTextView(data: step.title, fontWeight: FontWeight.w500),
            );
          },
          body: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            title: SimpleTextView(data: step.body, textColor: AppColors.blackColor.withOpacity(0.7)),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}
