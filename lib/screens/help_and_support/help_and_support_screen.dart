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
  final List<Step> _steps = [];
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
                  const SimpleTextView(data: "Help & Support", textColor: AppColors.whiteColor),
                  const SizedBox(height: 15),
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
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
              title: SimpleTextView(data: step.title, fontSize: 16, fontWeight: FontWeight.w500),
            );
          },
          body: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 10),
            title: SimpleTextView(data: step.body, textColor: AppColors.textColor),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}
