import 'package:flutter/material.dart';

import 'package:waiter_app/pages/home/home_page_body.dart';
import 'package:waiter_app/pages/home/home_page_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          HomePageHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: HomePageBody(),
          )),
        ],
      ),
    );
  }
}
