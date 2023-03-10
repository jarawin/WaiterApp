import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/provider/cartProvider.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../utils/colors.dart';

class FoodPageBody extends StatefulWidget {
  final String URL_BASE = "http://localhost:5390";
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.hPageView220;
  // late List<Food> reccomendedFoods;

  late Future<List<Food>> reccomendedFoods;

  List<Cart> cart = [];

  _addCart(Food food) {
    setState(() {
      cart.add(Cart(food: food, quantity: 1));
    });
  }

  @override
  void initState() {
    super.initState();
    reccomendedFoods = fetchFood();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<CartService>(builder: (_, cartService, __) {
    return FutureBuilder<List<Food>>(
        future: fetchFood(),
        builder: (context, snapshot) {
          if (snapshot.hasData || cart.isNotEmpty) {
            List<Food> reccomendedFoods = snapshot.data!;
            return Column(
              children: [
                // slider section
                SizedBox(
                  height: Dimensions.hPageView320,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: reccomendedFoods.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(
                            position, reccomendedFoods[position]);
                      }),
                ),
                // dots
                DotsIndicator(
                  dotsCount: reccomendedFoods.length,
                  position: _currPageValue,
                  decorator: DotsDecorator(
                    activeColor: AppColors.mainColor,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                // popular text
                SizedBox(
                  height: Dimensions.height30,
                ),
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
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

                // list of food items
                ListView.builder(
                    padding: EdgeInsets.only(top: Dimensions.height10),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: reccomendedFoods.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PopularFoodDetail(
                                        food: reccomendedFoods[index],
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
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white38,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            reccomendedFoods[index].image))),
                              ),
                              // text container
                              Expanded(
                                child: Container(
                                    height: Dimensions.wPageView100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              Dimensions.radius20),
                                          bottomRight: Radius.circular(
                                              Dimensions.radius20),
                                        ),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Dimensions.width10,
                                          right: Dimensions.width10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BigText(
                                              text:
                                                  reccomendedFoods[index].name),
                                          SizedBox(
                                            height: Dimensions.height10,
                                          ),
                                          SmallText(
                                              text:
                                                  "${reccomendedFoods[index].description.substring(0, 30)}..."),
                                          SizedBox(
                                            height: Dimensions.height10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconAndTextWidget(
                                                  icon: Icons.circle_sharp,
                                                  text: reccomendedFoods[index]
                                                      .category,
                                                  iconColor:
                                                      AppColors.iconColor1),
                                              IconAndTextWidget(
                                                  icon: Icons.paid,
                                                  text:
                                                      "${reccomendedFoods[index].price} บาท",
                                                  iconColor:
                                                      AppColors.iconColor2),
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
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
    // });
  }

  Future<List<Food>> fetchFood() async {
    try {
      final response =
          await http.get(Uri.parse("${widget.URL_BASE}/service/food"));
      String logResponse = response.statusCode.toString();
      if (response.statusCode == 200) {
        List<dynamic> responseJson =
            json.decode(response.body)['reccomendFoods'];
        return responseJson.map((m) => Food.fromJson(m)).toList();
      } else {
        return [
          Food(
            id: "1",
            name: "ข้าวผัดกระเพรา",
            description:
                """ข้าวผัดกระเพรา เป็นอาหารที่มีชื่อเสียงและเป็นที่รู้จักกันอย่างแพร่หลายในวงการอาหารไทย โดยมีส่วนประกอบหลักๆ คือ ข้าวสวยผัดกับใบกระเพรา และส่วนผสมอื่นๆ เช่น หมู/ไก่/เนื้อกุ้ง/ปลาหมึก และพริกขี้หนู ซึ่งจะให้รสชาติที่เผ็ดร้อน ซึ่งเป็นเอกลักษณ์ของอาหารชนิดนี้\n\nการทำข้าวผัดกระเพรา จะเริ่มต้นด้วยการผัดเนื้อหรือกุ้งกับกระเทียมและพริกขี้หนู จากนั้นก็เพิ่มใบกระเพราลงไปผัดให้เข้ากันกับเนื้อหรือกุ้ง หลังจากนั้นก็เทข้าวสวยลงไปผัดให้เข้ากับส่วนผสมทั้งหมด โดยอาจจะเพิ่มไข่ดาวลงไปประดับเพิ่มเติมให้กับเมนูนี้ได้อีกด้วย\n\nข้าวผัดกระเพรามีรสชาติที่เผ็ดร้อน และมีกลิ่นหอมจากใบกระเพรา ทำให้เป็นอาหารที่มีความเข้มข้นและอร่อยมากๆ นับเป็นเมนูสุดคลาสสิคของอาหารไทยที่เป็นที่รู้จักทั่วโลกและเป็นที่นิยมของนักท่องเที่ยวที่มาเยือนประเทศไทย""",
            image: "https://i.ibb.co/MBm7Vr6/food1.jpg",
            price: 60,
            rating: 4,
            category: "recommended",
          ),
          Food(
            id: "2",
            name: "ข้าวผัดหมู",
            description:
                """ข้าวผัดหมูเป็นเมนูอาหารที่เป็นที่รู้จักกันทั่วไปในวงการอาหารไทยและเป็นเมนูที่ได้รับความนิยมมากในทุกช่วงวัย โดยส่วนประกอบหลักของเมนูนี้ คือ ข้าวสวยผัดกับหมูสับ และผัก ซึ่งมักจะใช้ผักกาดขาว หรือผักกาดหอมในการผัด และอาจจะมีไข่ดาวเป็นเครื่องเพิ่มรสชาติให้กับข้าวผัดหมู\n\nการทำข้าวผัดหมู เริ่มต้นด้วยการผัดหมูสับกับกระเทียม และพริกขี้หนู จากนั้นก็เพิ่มข้าวสวยลงไปผัดให้เข้ากับหมูสับ และผัก ซึ่งสามารถเลือกใช้ผักได้ตามต้องการ หลังจากนั้นก็ตามด้วยการใส่ซีอิ๊วขาว และซอสปรุงรสต่างๆ ผสมเข้ากับเมนูนี้ ซึ่งจะช่วยเพิ่มรสชาติและกลิ่นหอมให้กับข้าวผัดหมู\n\nข้าวผัดหมูเป็นอาหารที่มีรสชาติอร่อย หอม และเป็นเมนูที่สามารถปรับแต่งได้ตามความชอบ โดยสามารถเพิ่มหรือลดปริมาณส่วนผสมต่างๆ ได้ และมักจะเป็นอาหารที่จะรับประทานกับอาหารว่าง หรือใช้เป็นอาหารจานเดียวก็ได้ โดยเป็นอาหารที่เหมาะสำหรับทุกคนที่ชอบรสชาติของอาหารไทยและเป็นอาหารที่เป็นที่นิยมอย่างแพร่หลาย""",
            image: "https://i.ibb.co/30gdjdW/food2.jpg",
            price: 80,
            rating: 3,
            category: "recommended",
          ),
          Food(
            id: "3",
            name: "ข้าวไข่เจียว",
            description:
                """ข้าวไข่เจียวเป็นเมนูอาหารที่นิยมและเป็นที่รู้จักกันอย่างแพร่หลายในวงการอาหารไทย ซึ่งเป็นอาหารที่ง่ายต่อการทำและสามารถรับประทานได้ตลอดทั้งวันไม่ว่าจะเป็นอาหารเช้า อาหารกลางวัน หรืออาหารเย็น\n\nส่วนประกอบหลักของข้าวไข่เจียวประกอบไปด้วย ข้าวสวย ไข่ไก่ และผักหรือเห็ดตามชอบ เมื่อทำเสร็จแล้วจะได้จานข้าวสวยที่ผัดกับไข่ไก่และผักหรือเห็ด ซึ่งจะมีรสชาติอร่อยและเป็นเมนูที่ทำให้คุณรู้สึกสะดุดตามประสบการณ์ของคุณ\n\nการทำข้าวไข่เจียวเริ่มต้นด้วยการตำไข่ให้เข้ากันกับเกลือ พร้อมทั้งเตรียมผักหรือเห็ดไว้ จากนั้นก็ผัดข้าวสวยในกระทะกับน้ำมันร้อน และเพิ่มไข่ที่เตรียมไว้ลงไปผัดให้เข้ากับข้าว ใส่ผักหรือเห็ดลงไปผัดเบาๆ แล้วก็จัดจานเสิร์ฟพร้อมรับประทาน\n\nข้าวไข่เจียวเป็นอาหารที่สามารถปรับแต่งได้ตามความชอบ เช่น สามารถเพิ่มส่วนผสมอื่นๆ เช่น หมูสับ กุ้งสด หรือไส้กรอกลงไปในเมนูได้ และเป็นเมนูที่รวดเร็วและสะดวกต่อการทำ ทำให้เป็นอาหารที่นิยมสำหรับคนที่ไม่มีเวลาเตรียมอาหาร""",
            image: "https://i.ibb.co/sQrZMbY/food3.webp",
            price: 30,
            rating: 5,
            category: "recommended",
          ),
        ];
      }
    } catch (e) {
      return [
        Food(
          id: "1",
          name: "ข้าวผัดกระเพรา",
          description:
              """ข้าวผัดกระเพรา เป็นอาหารที่มีชื่อเสียงและเป็นที่รู้จักกันอย่างแพร่หลายในวงการอาหารไทย โดยมีส่วนประกอบหลักๆ คือ ข้าวสวยผัดกับใบกระเพรา และส่วนผสมอื่นๆ เช่น หมู/ไก่/เนื้อกุ้ง/ปลาหมึก และพริกขี้หนู ซึ่งจะให้รสชาติที่เผ็ดร้อน ซึ่งเป็นเอกลักษณ์ของอาหารชนิดนี้\n\nการทำข้าวผัดกระเพรา จะเริ่มต้นด้วยการผัดเนื้อหรือกุ้งกับกระเทียมและพริกขี้หนู จากนั้นก็เพิ่มใบกระเพราลงไปผัดให้เข้ากันกับเนื้อหรือกุ้ง หลังจากนั้นก็เทข้าวสวยลงไปผัดให้เข้ากับส่วนผสมทั้งหมด โดยอาจจะเพิ่มไข่ดาวลงไปประดับเพิ่มเติมให้กับเมนูนี้ได้อีกด้วย\n\nข้าวผัดกระเพรามีรสชาติที่เผ็ดร้อน และมีกลิ่นหอมจากใบกระเพรา ทำให้เป็นอาหารที่มีความเข้มข้นและอร่อยมากๆ นับเป็นเมนูสุดคลาสสิคของอาหารไทยที่เป็นที่รู้จักทั่วโลกและเป็นที่นิยมของนักท่องเที่ยวที่มาเยือนประเทศไทย""",
          image: "https://i.ibb.co/MBm7Vr6/food1.jpg",
          price: 60,
          rating: 4,
          category: "recommended",
        ),
        Food(
          id: "2",
          name: "ข้าวผัดหมู",
          description:
              """ข้าวผัดหมูเป็นเมนูอาหารที่เป็นที่รู้จักกันทั่วไปในวงการอาหารไทยและเป็นเมนูที่ได้รับความนิยมมากในทุกช่วงวัย โดยส่วนประกอบหลักของเมนูนี้ คือ ข้าวสวยผัดกับหมูสับ และผัก ซึ่งมักจะใช้ผักกาดขาว หรือผักกาดหอมในการผัด และอาจจะมีไข่ดาวเป็นเครื่องเพิ่มรสชาติให้กับข้าวผัดหมู\n\nการทำข้าวผัดหมู เริ่มต้นด้วยการผัดหมูสับกับกระเทียม และพริกขี้หนู จากนั้นก็เพิ่มข้าวสวยลงไปผัดให้เข้ากับหมูสับ และผัก ซึ่งสามารถเลือกใช้ผักได้ตามต้องการ หลังจากนั้นก็ตามด้วยการใส่ซีอิ๊วขาว และซอสปรุงรสต่างๆ ผสมเข้ากับเมนูนี้ ซึ่งจะช่วยเพิ่มรสชาติและกลิ่นหอมให้กับข้าวผัดหมู\n\nข้าวผัดหมูเป็นอาหารที่มีรสชาติอร่อย หอม และเป็นเมนูที่สามารถปรับแต่งได้ตามความชอบ โดยสามารถเพิ่มหรือลดปริมาณส่วนผสมต่างๆ ได้ และมักจะเป็นอาหารที่จะรับประทานกับอาหารว่าง หรือใช้เป็นอาหารจานเดียวก็ได้ โดยเป็นอาหารที่เหมาะสำหรับทุกคนที่ชอบรสชาติของอาหารไทยและเป็นอาหารที่เป็นที่นิยมอย่างแพร่หลาย""",
          image: "https://i.ibb.co/30gdjdW/food2.jpg",
          price: 80,
          rating: 3,
          category: "recommended",
        ),
        Food(
          id: "3",
          name: "ข้าวไข่เจียว",
          description:
              """ข้าวไข่เจียวเป็นเมนูอาหารที่นิยมและเป็นที่รู้จักกันอย่างแพร่หลายในวงการอาหารไทย ซึ่งเป็นอาหารที่ง่ายต่อการทำและสามารถรับประทานได้ตลอดทั้งวันไม่ว่าจะเป็นอาหารเช้า อาหารกลางวัน หรืออาหารเย็น\n\nส่วนประกอบหลักของข้าวไข่เจียวประกอบไปด้วย ข้าวสวย ไข่ไก่ และผักหรือเห็ดตามชอบ เมื่อทำเสร็จแล้วจะได้จานข้าวสวยที่ผัดกับไข่ไก่และผักหรือเห็ด ซึ่งจะมีรสชาติอร่อยและเป็นเมนูที่ทำให้คุณรู้สึกสะดุดตามประสบการณ์ของคุณ\n\nการทำข้าวไข่เจียวเริ่มต้นด้วยการตำไข่ให้เข้ากันกับเกลือ พร้อมทั้งเตรียมผักหรือเห็ดไว้ จากนั้นก็ผัดข้าวสวยในกระทะกับน้ำมันร้อน และเพิ่มไข่ที่เตรียมไว้ลงไปผัดให้เข้ากับข้าว ใส่ผักหรือเห็ดลงไปผัดเบาๆ แล้วก็จัดจานเสิร์ฟพร้อมรับประทาน\n\nข้าวไข่เจียวเป็นอาหารที่สามารถปรับแต่งได้ตามความชอบ เช่น สามารถเพิ่มส่วนผสมอื่นๆ เช่น หมูสับ กุ้งสด หรือไส้กรอกลงไปในเมนูได้ และเป็นเมนูที่รวดเร็วและสะดวกต่อการทำ ทำให้เป็นอาหารที่นิยมสำหรับคนที่ไม่มีเวลาเตรียมอาหาร""",
          image: "https://i.ibb.co/sQrZMbY/food3.webp",
          price: 30,
          rating: 5,
          category: "recommended",
        ),
      ];
    }
  }

  Widget _buildPageItem(int index, Food food) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PopularFoodDetail(food: food)));
      },
      child: Transform(
        transform: matrix,
        child: Stack(
          children: [
            Container(
              height: Dimensions.hPageView220,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven
                      ? const Color(0xFF69c5df)
                      : const Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      // image: NetworkImage("${widget.URL_BASE}${food.image}"))),
                      image: NetworkImage("${food.image}"))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.hPageView120,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      left: Dimensions.width15,
                      right: Dimensions.width15),
                  child: AppColumn(
                    text: food.name,
                    category: food.category,
                    rating: food.rating,
                    price: food.price,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
