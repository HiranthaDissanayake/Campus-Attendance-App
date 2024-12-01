import 'package:attendenz/constants/colors.dart';
import 'package:attendenz/models/subjectCategory.dart';
import 'package:attendenz/screens/add_new_screen.dart';
import 'package:attendenz/screens/chart_screen.dart';
import 'package:attendenz/screens/home_screen.dart';
import 'package:attendenz/services/absent_services.dart';
import 'package:attendenz/services/present_services.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentPageIndex = 0;

  List<Subject> presentList = [];
  List<Subject> absentList = [];

  // function to fetch presents
  void fetchAllPresents() async{
    List<Subject> loadedSubjects = await PresentServices().loadPresents();
    setState(() {
      presentList = loadedSubjects;
    });
  }

  // function to fetch absents
  void fetchAllAbsents() async{
    List<Subject> loadedAbsents = await AbsentServices().loadAbsents();
    setState(() {
      absentList = loadedAbsents;
    });
  }

  // add new present
  void addNewPresent (Subject newPresent){
    PresentServices().savePresents(newPresent, context);

    // update the list of presents
    setState(() {
      presentList.add(newPresent);
    });
  }

  // add new absent
  void addNewAbsent (Subject newAbsent){
    AbsentServices().saveAbsent(newAbsent, context);

    // update the list of absents
    setState(() {
      absentList.add(newAbsent);
      print(presentList.length);
    });
  }

  @override
  void initState() {
    setState(() {
      fetchAllPresents();
      fetchAllAbsents();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // screens list
    final List<Widget> pages = [
      AddNewScreen(addPresent: addNewPresent, addAbsent: addNewAbsent),
      HomeScreen(),
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