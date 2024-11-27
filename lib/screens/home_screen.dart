import 'package:attendenz/constants/colors.dart';
import 'package:attendenz/services/user_services.dart';
import 'package:attendenz/widgets/present_absent_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // for store the username
  String username = "";

  @override
  void initState() {
    // get the username from the shared pref
    UserServices.getUserData().then((value){
      if(value["username"] != null){
        setState(() {
          username = value["username"]!;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
        SingleChildScrollView(

          // main column
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                  color: MainColor.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(130),
                    topLeft: Radius.circular(50)
                  )
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Welcome $username",
                            style: const TextStyle(
                            color: Color.fromARGB(255, 254, 253, 253),
                            fontSize: 22,
                            fontWeight: FontWeight.w600
                          ),),
                        ],
                      ), 
                    ),

                    const Padding(
                      padding:  EdgeInsets.all(35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PresentAbsentCard(
                            title: "Presents",
                            total: 50,
                            bgColor: presentColor,
                            bIcon: Icons.perm_contact_cal_rounded,
                            ),
                          
                          PresentAbsentCard(
                            title: "Absents",
                            total: 3,
                            bgColor: absentColor,
                            bIcon: Icons.person_off_rounded,
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              )
              
            ],
          ),
        )
      ),
    );
  }
}