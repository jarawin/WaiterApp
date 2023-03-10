import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/provider/cartProvider.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../cart/cart_page.dart';

class PopularFoodDetail extends StatefulWidget {
  final String URL_BASE = "http://localhost:5390";
  final Food food;
  const PopularFoodDetail({Key? key, required this.food}) : super(key: key);

  @override
  State<PopularFoodDetail> createState() => _PopularFoodDetailState();
}

class _PopularFoodDetailState extends State<PopularFoodDetail> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartService>(builder: (_, cartService, __) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.img350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          // image: AssetImage("assets/images/food1.jpg"))),
                          // image: NetworkImage(
                          //     "${widget.URL_BASE}/${widget.food.image}"))),
                          image: NetworkImage("${widget.food.image}"))),
                )),
            Positioned(
                top: Dimensions.height45,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const AppIcon(icon: Icons.arrow_back_ios)),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartPage()));
                          // Get.to(() => const CartPage());
                        },
                        child:
                            const AppIcon(icon: Icons.shopping_cart_outlined))
                  ],
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.img350 - Dimensions.height20,
              child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        text: widget.food.name,
                        category: widget.food.category,
                        rating: widget.food.rating,
                        price: widget.food.price,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      BigText(text: "ข้อมูลเพิ่มเติม", size: Dimensions.font17),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandableTextWidget(
                              text: widget.food.description),
                        ),
                      ),
                    ],
                  )),
            ),
            // const ExpandableTextWidget(text: "Introduce")
          ],
        ),
        bottomNavigationBar: Container(
            height: Dimensions.hPageView120,
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_quantity > 1) {
                                _quantity--;
                              }
                            });
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        BigText(
                          text: "$_quantity",
                        ),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
                        ),
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    cartService.addToCart(widget.food, _quantity);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height20),
                    child: BigText(
                      text: "Add to cart",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20)),
                  ),
                )
              ],
            )),
      );
    });
  }
}
