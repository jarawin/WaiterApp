import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/big_text.dart';

class CallWaiter extends StatelessWidget {
  const CallWaiter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: BigText(
            text: "Call Waiter",
            color: Colors.white,
            size: Dimensions.font20,
          ),
          backgroundColor: Color(0xFF89dad0),
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
                Get.snackbar(
                  "Employee Called",
                  "The employee has been notified.",
                  snackPosition: SnackPosition.TOP,
                  duration: Duration(seconds: 2),
                );
                //_showEmployeeCalledDialog(context);
              },
              child: Text('Call Employee'),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent,
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
