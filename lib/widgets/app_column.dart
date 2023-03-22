import 'package:flutter/material.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/big_text.dart';
import 'package:waiter_app/widgets/icon_and_text_widget.dart';
import 'package:waiter_app/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final int rating;
  final int price;
  final String text;
  final String category;
  const AppColumn({
    Key? key,
    required this.text,
    required this.rating,
    required this.category,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  rating,
                  (index) => Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                        size: Dimensions.icon15,
                      )),
            ),
            Wrap(
              children: List.generate(
                  5 - rating,
                  (index) => Icon(
                        Icons.star,
                        color: AppColors.textColor,
                        size: Dimensions.icon15,
                      )),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(
              text: "($rating)",
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: category.toLowerCase() == "recommended" ? Icons.recommend : Icons.stars_rounded,
                text:
                    "${category[0].toUpperCase()}${category.substring(1).toLowerCase()}",
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(
                icon: Icons.sell,
                text: "$price บาท",
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
