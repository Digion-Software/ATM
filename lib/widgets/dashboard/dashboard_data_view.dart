import 'package:atm/config/app_colors.dart';
import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class DashboardDataView extends StatelessWidget {
  const DashboardDataView({Key? key, required this.title, required this.data, this.valueColor = AppColors.textBluGreyColor})
      : super(key: key);
  final String title;
  final String data;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DescriptionTextView(
          data: title,
          fontSize: 14,
          textColor: AppColors.textColor.withOpacity(0.8),
          fontWeight: FontWeight.w500,
        ),
        DescriptionTextView(
          data: data,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          textColor: valueColor,
        ),
      ],
    );
  }
}
