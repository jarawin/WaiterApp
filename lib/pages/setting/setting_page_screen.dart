// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/providers/customerProvider.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/account_widget.dart';
import 'package:waiter_app/widgets/app_icon.dart';
import 'package:waiter_app/widgets/big_text.dart';



class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
        builder: (_, customerProvider, __) {
          print("userId: ${customerProvider.userId}");
          print("phone: ${customerProvider.phone}");
          print("point: ${customerProvider.point}");

      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.mainColor,
            // elevation: 1,
            title: BigText(
              text: "Setting",
              color: Colors.white,
              size: Dimensions.font20,
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(
              top: Dimensions.height20,
            ),
            child: Column(
              children: [
                // profile
                AppIcon(
                  icon: Icons.person,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height45 + Dimensions.width30,
                  size: Dimensions.height15 * 10,
                ),
                // userId
                SizedBox(
                  height: Dimensions.height30,
                ),
                AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.person,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height10 * 5 / 2,
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: customerProvider?.userId ?? "UserId not found",
                    // color: AppColors.mainColor,
                    // size: Dimensions.font20,
                  ),
                ),
                // phone
                SizedBox(
                  height: Dimensions.height20,
                ),
                AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.person,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height10 * 5 / 2,
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: "Account",
                    // color: AppColors.mainColor,
                    // size: Dimensions.font20,
                  ),
                ),
                // point
                SizedBox(
                  height: Dimensions.height20,
                ),
                AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.person,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height10 * 5 / 2,
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: "Account",
                    // color: AppColors.mainColor,
                    // size: Dimensions.font20,
                  ),
                ),
                // logout
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height35,
                  margin: EdgeInsets.only(
                    left: Dimensions.width100,
                    right: Dimensions.width100,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      customerProvider.logout();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/", (Route<dynamic> route) => false);
                    },
                    child: const Text("Logout",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
