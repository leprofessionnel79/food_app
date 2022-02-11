import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firsthalftext;
  late String secondhalftext;

  bool hiddentext = true;

  double textHeight = Dimensions.screenHeight / 3.7;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firsthalftext = widget.text.substring(0, textHeight.toInt());
      secondhalftext =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firsthalftext = widget.text;
      secondhalftext = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondhalftext.isEmpty
          ? SmallText(
              text: firsthalftext,
              size: Dimensions.font17,
              color: AppColors.paraColor,
              height: 1.5,
            )
          : Column(
              children: [
                SmallText(
                  text: hiddentext
                      ? (firsthalftext + "...")
                      : (firsthalftext + secondhalftext),
                  size: Dimensions.font17,
                  color: AppColors.paraColor,
                  height: 1.5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddentext = !hiddentext;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddentext ? "Show more" : "Show less",
                        color: AppColors.mainColor,
                        size: Dimensions.font17,
                      ),
                      Icon(
                        hiddentext
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
