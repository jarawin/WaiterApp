import 'package:flutter/material.dart';

class OrderFood extends StatelessWidget {
  const OrderFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
          child: Text('หน้าออเดอร์ที่สั่ง')),
    );
  }
}
