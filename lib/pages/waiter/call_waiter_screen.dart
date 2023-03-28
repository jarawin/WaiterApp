import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/providers/customerProvider.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/config.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/big_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CallWaiter extends StatelessWidget {
  static const _BaseURL = Config.URL_BASE;
  const CallWaiter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(builder: (_, customerService, __) {
      Future<void> callWaiter() async {
        final response = await http.post(
          Uri.parse("$_BaseURL/service/waiter"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "userId": customerService.userId,
          }),
        );

        if (response.statusCode == 200 || true) {
          Get.snackbar(
            "Success",
            "Call waiter successfully please wait for a moment",
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
      }

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: BigText(
            text: "Call Waiter",
            color: Colors.white,
            size: Dimensions.font20,
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                'https://cdn4.iconfinder.com/data/icons/hotel-facilities-1/512/Special-request-512.png',
                height: 200,
              ),
              ElevatedButton(
                onPressed: () {
                  callWaiter();
                },
                child: const Text('Call Waiter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontStyle: FontStyle.normal),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
//เเบบpopup
/* void _showEmployeeCalledDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Employee Called'),
          content: Text('The employee has been notified.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}*/
