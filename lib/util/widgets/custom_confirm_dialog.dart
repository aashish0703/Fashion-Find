// import 'package:flutter/material.dart';
//
// import 'custom_button.dart';
//
//
// class CustomConfirmDialog {
//
//
//   Future confirmDialog(BuildContext context, String title, String content, ) {
//     return showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text(title),
//           content: Text(content),
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CustomButton(
//                   onTap: () {},
//                   width: 120,
//                   text: "Delete",
//                 ),
//                 const SizedBox(width: 20,),
//                 CustomButton(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   width: 120,
//                   text: "Cancel",
//                 )
//               ],
//             )
//           ],
//         )
//
//     );
//   }
//
// }

import 'package:fashion_find/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomConfirmDialog extends StatelessWidget {
  const CustomConfirmDialog({super.key, required this.title, required this.content, required this.onTap, required this.textOnOption});

  final Text title;
  final Text content;
  final VoidCallback onTap;
  final String textOnOption;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
                onTap: onTap,
                width: 120,
                text: textOnOption
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.05,
            ),
            CustomButton(
                onTap: () {Navigator.pop(context);},
                width: 120,
                text: "Cancel"
            ),
          ],
        )
      ],
    );
  }
}
