// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:waiter_app/models/order.dart';
import 'package:waiter_app/providers/customerProvider.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/config.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/big_text.dart';
import 'package:waiter_app/widgets/small_text.dart';

Future<List<Order>> fetchOrders(context) async {
  const _BaseUrl = Config.URL_BASE;

  String userId = Provider.of<CustomerProvider>(context, listen: false).userId;

  final response =
      await http.get(Uri.parse('$_BaseUrl/service/order?userId=$userId'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body)['data'];
    return data.map<Order>((json) => Order.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load orders');
  }
}

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  static const _BaseUrl = Config.URL_BASE;
  late Future<List<Order>> futureOrders;
  double _totalPrice = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrders(context).then((orders) {
      setState(() {
        _totalPrice = calculateTotalPrice(orders);
      });
      return orders;
    });
  }

  Future<void> checkoutAllOrder() async {
    String userId = Provider.of<CustomerProvider>(context, listen: false).userId;
    setState(() {
      _isLoading = true;
    });
    final response = await http.post(
      Uri.parse("$_BaseUrl/service/checkout"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userId": userId,
      }),
    );

    if (response.statusCode == 200 || true) {
      Get.snackbar(
        "Success",
        "Checkout successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      Navigator.pushNamed(context, '/home');

      print('Data successfully posted');
    } else {
      print('Failed to post data: ${response.statusCode}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  double calculateTotalPrice(List<Order> orders) {
    double totalPrice = 0;
    for (var order in orders) {
      totalPrice += order.getTotalPrice();
    }
    return totalPrice;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Order Food', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
        margin: EdgeInsets.only(
            top: Dimensions.height20,
            left: Dimensions.width20,
            right: Dimensions.width20),
        child: FutureBuilder<List<Order>>(
            future: futureOrders,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          "$_BaseUrl/images/empty_cart.png",
                          height: MediaQuery.of(context).size.height * 0.22,
                        ),
                        SmallText(
                          text: "No items in order.",
                          size: Dimensions.font16,
                        )
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data![index];
                      return Container(
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                                text:
                                    "OID: ${order.orderId} - ${order?.status ?? "Pending"}"),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(order.items.length,
                                      (index) {
                                    return Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15 / 2),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "$_BaseUrl${order.items[index].food.image}",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }

              // By default, show a loading spinner.
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              );
            }),
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
                      BigText(
                        text: "฿ $_totalPrice",
                      ),
                    ],
                  )),
              GestureDetector(
                onTap: () {
                  _isLoading ? null :
                  checkoutAllOrder();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height20),
                  child:  _isLoading ? const CircularProgressIndicator(color: Colors.white,) : BigText(
                    text: "Check out",
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
  }
}
