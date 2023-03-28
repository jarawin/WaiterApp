import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/pages/home/home_page_body.dart';
import 'package:waiter_app/providers/customerProvider.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/big_text.dart';
import 'package:waiter_app/widgets/small_text.dart';
import 'package:waiter_app/providers/cartProvider.dart';

class PointPage extends StatelessWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(builder: (_, customerProvider, __) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: BigText(
            text: "Point of User",
            color: Colors.white,
            size: Dimensions.font20,
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 190,
                height: 190,
                alignment: Alignment.center,
                child: Text(
                  "${customerProvider.point}", //${Customer.cus[0].point}
                  style: const TextStyle(
                    color: AppColors.yellowColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  border: Border.all(
                    color: AppColors.mainColor,
                    style: BorderStyle.solid,
                    width: 25,
                  ),
                  color: Colors.transparent,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Phone Number: ${customerProvider.phone}', //${Customer.cus[0].phone}
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
