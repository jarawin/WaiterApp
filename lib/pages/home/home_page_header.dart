import 'package:flutter/material.dart';

import 'package:waiter_app/widgets/big_text.dart';
import 'package:waiter_app/widgets/small_text.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/dimensions.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.height45, bottom: Dimensions.height15),
      padding: EdgeInsets.only(
          left: Dimensions.width20, right: Dimensions.width20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              BigText(
                text: "WaiterApp",
                color: AppColors.mainColor,
                size: Dimensions.font30,
              ),
              Row(
                children: [
                  SmallText(
                    text: "ตามสั่งหลังมอ",
                    color: Colors.black54,
                  ),
                  const Icon(Icons.arrow_drop_down_rounded)
                ],
              )
            ],
          ),
          Center(
            child: Container(
              width: Dimensions.width45,
              height: Dimensions.height45,
              child: Icon(Icons.search,
                  color: Colors.white, size: Dimensions.icon25),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(Dimensions.radius15),
                color: AppColors.mainColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
