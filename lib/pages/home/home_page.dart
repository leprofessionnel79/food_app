import 'package:flutter/material.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    MainFoodPage(),
    Container(
      child: Center(
        child: Text("next1"),
      ),
    ),
    Container(
      child: Center(
        child: Text("next2"),
      ),
    ),
    Container(
      child: Center(
        child: Text("next3"),
      ),
    ),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive), title: Text("History")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("Cart")),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Me")),
        ],
      ),
    );
  }
}
