// ignore_for_file: must_be_immutable

// ***********************************************************************
// This is a Flutter file for the "Setting Page" of a mobile app.
// It imports necessary packages, including flutter/material.dart,
// http/http.dart, provider.dart, and defines a SettingPage widget.
//
// The widget contains a Consumer widget that listens to changes to
// a CustomerProvider object and updates the page accordingly.
// It displays the user's profile picture, user ID, phone number,
// and current point balance. Additionally, it includes a logout button
// at the bottom of the page.
//
// The substringWithEllipsis function is defined to allow for the user ID
// to be displayed in an abbreviated format if it exceeds a certain length.
//
// The overall structure of the widget is a Scaffold containing an AppBar
// with a title, and a Container that displays the user information
// and logout button in a column format.
// ***********************************************************************

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

  String substringWithEllipsis(String inputString, int n) {
    if (inputString.length <= n) return inputString;
    return inputString.substring(0, n) + '...';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(builder: (_, customerProvider, __) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
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
                    backgroundColor: AppColors.textColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height10 * 5 / 2,
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: substringWithEllipsis(customerProvider.userId, 20),
                  ),
                ),
                // phone
                SizedBox(
                  height: Dimensions.height20,
                ),
                AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.phone,
                    backgroundColor: AppColors.yellowColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height10 * 5 / 2,
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: customerProvider.phone,
                  ),
                ),
                // point
                SizedBox(
                  height: Dimensions.height20,
                ),
                AccountWidget(
                  appIcon: AppIcon(
                    icon: Icons.credit_score,
                    backgroundColor: AppColors.yellowColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height10 * 5 / 2,
                    size: Dimensions.height10 * 5,
                  ),
                  bigText: BigText(
                    text: "${customerProvider.point.toString()} point",
                  ),
                ),
                // logout
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height45,
                  margin: EdgeInsets.only(
                    top: Dimensions.height20,
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
