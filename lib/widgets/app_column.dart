import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';

import 'icon_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10 / 2,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                        size: 20,
                      )),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: "1327"),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconTextWidget(
                iconData: Icons.circle_sharp,
                text: "normal",
                iconColor: AppColors.iconColor1),
            IconTextWidget(
                iconData: Icons.location_on,
                text: "1.7 km",
                iconColor: AppColors.mainColor),
            IconTextWidget(
                iconData: Icons.access_time_rounded,
                text: "32min",
                iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
