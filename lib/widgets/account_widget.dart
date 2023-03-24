// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/app_icon.dart';
import 'package:waiter_app/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.width10,
        bottom: Dimensions.width10,
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          bigText
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.width10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      )
    );
  }
}
