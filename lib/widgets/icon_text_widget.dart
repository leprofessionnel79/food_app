import 'package:flutter/material.dart';
import 'package:food_app/widgets/small_text.dart';

class IconTextWidget extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color iconColor;
  
   IconTextWidget({Key? key,
   required this.iconData,
    required this.text,
    required this.iconColor,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData,color: iconColor,),
        SizedBox(width: 7,),
        SmallText(text: text)
      ],
    );
  }
}
