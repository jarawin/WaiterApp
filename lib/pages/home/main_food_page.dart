import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/call_waiter_screen.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/pages/home/main_food_screen.dart';
import 'package:food_delivery/pages/home/order_food_screen.dart';
import 'package:food_delivery/pages/home/point_page_screen.dart';
import 'package:food_delivery/pages/home/setting_page_screen.dart';

//หน้าหลัก ใช้เชื่อมfileหน้าอื่นๆ
class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  List<Map<String, dynamic>>? _pages;
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void initState() {
    //ตรงนี้คือกดไอคอนเเล้วจะเชื่อมไปหน้านั้นๆนะ
    _pages = [
      {'page': const MainFoodScreen(), 'title': 'Categories'},
      {'page': Pointpage(), 'title': 'Your Favorites'},
      {'page': OrderFood(), 'title': 'Your Favorites'},
      {'page': CallWaiter(), 'title': 'Your Favorites'},
      {'page': SettingPage(), 'title': 'Your Favorites'},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("current height is ${MediaQuery.of(context).size.height.toString()}");
    // print("current width is ${MediaQuery.of(context).size.width.toString()}");

    return Scaffold(
      body: _pages![_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Color(0xFF89dad0),
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            tooltip: 'Home',
            label: 'Home',
            // backgroundColor: Colors.blue.withOpacity(1.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_score),
            tooltip: 'Point',
            label: 'Point',
            // backgroundColor: Colors.blue.withOpacity(1.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            tooltip: 'Order',
            label: 'Order',
            // backgroundColor: Colors.blue.withOpacity(1.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            tooltip: 'Waiter',
            label: 'Waiter',
            //backgroundColor: Colors.blue.withOpacity(1.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            tooltip: 'Setting',
            label: 'Setting',
            //backgroundColor: Colors.blue.withOpacity(1.0),
          ),
        ],
      ),
    );
  }
}
