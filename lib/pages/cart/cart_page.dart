import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/pages/cart/cart_item_list.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:provider/provider.dart';

import '../../provider/cartProvider.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  final String URL_BASE = "http://localhost:5390";
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> _cartList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<CartService>(builder: (_, cartService, __) {
      _cartList = cartService.getCart();

      return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height20 * 3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        size: Dimensions.icon30,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width20 * 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.home,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        size: Dimensions.icon30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.shopping_cart,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        size: Dimensions.icon30,
                      ),
                    ),
                  ],
                )),
            Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height15,
                  ),
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (context, index) {
                          return CartItemList(
                            index: index,
                          );
                        },
                      )),
                ))
          ],
        ),
      );
    });
  }
}
