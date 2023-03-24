import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter_app/pages/login/LoginPage.dart';

import 'package:waiter_app/pages/waiter/call_waiter_screen.dart';
import 'package:waiter_app/pages/home/home_page.dart';
import 'package:waiter_app/pages/order/order_food_screen.dart';
import 'package:waiter_app/pages/point/point_page_screen.dart';
import 'package:waiter_app/pages/setting/setting_page_screen.dart';
import 'package:waiter_app/providers/cartProvider.dart';
import 'package:waiter_app/providers/customerProvider.dart';
import 'package:waiter_app/providers/foodProvider.dart';

import 'package:waiter_app/utils/colors.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ListenableProvider(create: (context) => CartService()),
      ListenableProvider(create: (context) => FoodProvider()),
      ListenableProvider(create: (context) => CustomerProvider()),
    ],
    child: GetMaterialApp(
      title: 'Waiter App',
      initialRoute: '/',
      routes: {
        '/home': (context) => const WaiterApp(),
        '/point': (context) => const PointPage(),
        '/order': (context) => const OrderFood(),
        '/waiter': (context) => const CallWaiter(),
        '/setting': (context) => const SettingPage(),
      },
      home: const CustomerLoginPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
    ),
  ));
}

class WaiterApp extends StatefulWidget {
  const WaiterApp({Key? key}) : super(key: key);

  @override
  State<WaiterApp> createState() => _WaiterAppState();
}

class _WaiterAppState extends State<WaiterApp> {
  int _selectedPageIndex = 0;

  final _pages = [
    {'page': const HomePage(), 'title': 'Home', 'icon': Icons.home},
    {'page': const PointPage(), 'title': 'Point', 'icon': Icons.credit_score},
    {
      'page': const OrderFood(),
      'title': 'Order',
      'icon': Icons.restaurant_menu
    },
    {'page': const CallWaiter(), 'title': 'Waiter', 'icon': Icons.room_service},
    {'page': const SettingPage(), 'title': 'Setting', 'icon': Icons.settings},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'] as Widget?,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedPageIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: _pages.map((page) {
          return BottomNavigationBarItem(
            icon: Icon(page['icon'] as IconData?),
            label: page['title'] as String?,
          );
        }).toList(),
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
      ),
    );
  }
}
