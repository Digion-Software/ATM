import 'package:atm/widgets/common/text_widgets.dart';
import 'package:flutter/material.dart';

class DashboardDataView extends StatelessWidget {
  const DashboardDataView({Key? key, required this.title, required this.data, required this.statusColor})
      : super(key: key);
  final String title;
  final String data;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DescriptionTextView(data: title,fontSize: 14),
              DescriptionTextView(
                data: data,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
