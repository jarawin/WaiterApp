// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:waiter_app/models/food.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/config.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/big_text.dart';
import 'package:waiter_app/widgets/icon_and_text_widget.dart';
import 'package:waiter_app/widgets/small_text.dart';
import 'package:waiter_app/pages/home/food/food_detail.dart';

class PopularFoodList extends StatefulWidget {
  final String URL_BASE = Config.URL_BASE;
  final List<Food> popularFoods;

  const PopularFoodList({Key? key, required this.popularFoods})
      : super(key: key);

  @override
  State<PopularFoodList> createState() => _PopularFoodListState();
}

class _PopularFoodListState extends State<PopularFoodList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20, top: Dimensions.height10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: "Popular",
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width5,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 1),
                child: SmallText(
                  text: "Food parring",
                ),
              )
            ],
          ),
        ),
        ListView.builder(
            padding: EdgeInsets.only(top: Dimensions.height10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.popularFoods.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodDetail(
                                food: widget.popularFoods[index],
                              )));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10),
                  child: Row(
                    children: [
                      // image section
                      Container(
                        height: Dimensions.wPageView120,
                        width: Dimensions.wPageView120,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "${widget.URL_BASE}/${widget.popularFoods[index].image}"))),
                      ),
                      // text container
                      Expanded(
                        child: Container(
                            height: Dimensions.wPageView100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                      text: widget.popularFoods[index].name),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  SmallText(
                                      text:
                                          "${widget.popularFoods[index].description.substring(0, 30)}..."),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndTextWidget(
                                          icon: widget.popularFoods[index]
                                                      .category
                                                      .toLowerCase() ==
                                                  "recommended"
                                              ? Icons.recommend
                                              : Icons.stars_rounded,
                                          text: widget
                                              .popularFoods[index].category,
                                          iconColor: AppColors.iconColor1),
                                      IconAndTextWidget(
                                          icon: Icons.sell,
                                          text:
                                              "${widget.popularFoods[index].price} บาท",
                                          iconColor: AppColors.iconColor2),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
