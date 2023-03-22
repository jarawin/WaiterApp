// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:waiter_app/providers/cartProvider.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/config.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/big_text.dart';
import 'package:waiter_app/models/cart.dart';

class CartItemList extends StatefulWidget {
  final int index;
  const CartItemList({Key? key, required this.index}) : super(key: key);

  @override
  State<CartItemList> createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  List<Cart> _cartList = [];
  int _quantity = 1;
  final String URL_BASE = Config.URL_BASE;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartService>(builder: (_, cartService, __) {
      _cartList = cartService.getCart();
      _quantity = _cartList[widget.index].quantity;

      return SizedBox(
        height: 100,
        width: double.maxFinite,
        child: Row(
          children: [
            Container(
              height: Dimensions.height20 * 5,
              width: Dimensions.width20 * 5,
              margin: EdgeInsets.only(
                bottom: Dimensions.height10,
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "$URL_BASE/${_cartList[widget.index].food.image}"),
                      fit: BoxFit.cover),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20)),
            ),
            SizedBox(
              width: Dimensions.width20,
            ),
            Expanded(
                child: SizedBox(
              height: Dimensions.height20 * 5,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BigText(
                      text: _cartList[widget.index].food.name,
                      color: Colors.black54,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: "\฿ ${_cartList[widget.index].getSumPrice()}",
                          color: Colors.red,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width5,
                                vertical: Dimensions.height5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20)),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    cartService.decreaseQuantity(
                                        _cartList[widget.index].food);
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
                                  text: _quantity.toString(),
                                ),
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cartService.increaseQuantity(
                                        _cartList[widget.index].food);
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.signColor,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    )
                  ]),
            ))
          ],
        ),
      );
    });
  }
}
