import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hideText = true;

  double textHeight = Dimensions.hPageView150;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? SmallText(
                height: Dimensions.height1_5,
                text: firstHalf,
                size: Dimensions.font15,
              )
            : Column(
                children: [
                  SmallText(
                      height: Dimensions.height1_5,
                      size: Dimensions.font15,
                      text: hideText
                          ? (firstHalf + "...")
                          : (firstHalf + secondHalf)),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SmallText(
                          text: hideText ? "show more" : "hidden",
                          color: AppColors.mainColor,
                        ),
                        Icon(
                          hideText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        hideText = !hideText;
                      });
                    },
                  ),
                ],
              ));
  }
}
