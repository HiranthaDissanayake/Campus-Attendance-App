import 'package:attendenz/constants/colors.dart';
import 'package:attendenz/screens/add_new_screen.dart';
import 'package:attendenz/screens/chart_screen.dart';
import 'package:attendenz/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    // screens list
    final List<Widget> pages = [
      AddNewScreen(),
      HomeScreen(),
      AddNewScreen(),
      ChartScreen()
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: MainColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500
        ),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Container(
              decoration: const BoxDecoration(
                color: MainColor,
                shape: BoxShape.circle
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 50,
              ),
            ),
            label: "",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined_sharp),
            label: "View Chart",
          ),
        ]
        ),
        body: pages[_currentPageIndex],
    );
  }
}