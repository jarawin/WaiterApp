import 'package:flutter/material.dart';
import 'package:waiter_app/pages/home/home_page_body.dart';
import 'package:waiter_app/utils/colors.dart';
import 'package:waiter_app/utils/dimensions.dart';
import 'package:waiter_app/widgets/big_text.dart';
import 'package:waiter_app/widgets/small_text.dart';

class PointPage extends StatelessWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Customer Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              child: Text(
                'point: ', //${Customer.cus[0].point}
                style: TextStyle(
                  color: Colors.blueAccent[200],
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(
                  color: Color(0xff7E89FC),
                  style: BorderStyle.solid,
                  width: 25,
                ),
                color: Colors.transparent,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Phone Number: ',//${Customer.cus[0].phone}

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
  }
}



