// import 'package:atm/config/app_colors.dart';
// import 'package:atm/config/app_images.dart';
// import 'package:atm/widgets/common/button_view.dart';
// import 'package:atm/widgets/common/text_widgets.dart';
// import 'package:flutter/material.dart';
//
// class CommonScaffold extends StatelessWidget {
//   const CommonScaffold({Key? key, required this.title, this.isDashboard = false, required this.child})
//       : super(key: key);
//   final String title;
//   final bool? isDashboard;
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: Stack(
//         children: [
//           const Image(image: AssetImage(AppImages.bgShape)),
//           SizedBox(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SafeArea(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 10),
//                         isDashboard! ? const SizedBox() : const BackArrowButtonView(color: AppColors.whiteColor),
//                         isDashboard! ? const SizedBox() : const SizedBox(height: 15),
//                         TitleTextView(data: title, textColor: AppColors.whiteColor),
//                         isDashboard!
//                             ? const SizedBox(
//                                 height: 30,
//                               )
//                             : const SizedBox(height: 5),
//                       ],
//                     ),
//                   ),
//                   Expanded(child: child),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
