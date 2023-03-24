// ******************************************************************
// This is the implementation of the HomePage widget in the waiter_app.
//
// The HomePage is a StatefulWidget that contains two child widgets:
// HomePageHeader and HomePageBody.
//
// The HomePageHeader widget contains the app logo, search bar, and menu icon.
//
// The HomePageBody widget contains a list of available restaurant items,
// where the user can select an item and add it to their cart.
//
// The HomePage widget is wrapped in a Scaffold that provides basic structural
// elements for the page, including an app bar and the main body of the page.
//
// Overall, the HomePage provides a complete UI for browsing available
// items and adding them to the user's cart.
// ******************************************************************

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
