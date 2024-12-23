import 'package:attendenz/constants/colors.dart';
import 'package:attendenz/models/subjectCategory.dart';
import 'package:attendenz/services/user_services.dart';
import 'package:attendenz/widgets/absent_card.dart';
import 'package:attendenz/widgets/pie_chart.dart';
import 'package:attendenz/widgets/present_absent_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {


  final List<Subject> presentList;
  final List<Subject> absentList;

  const HomeScreen({
    super.key,
    required this.absentList,
    required this.presentList
    });

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
      backgroundColor: const Color.fromARGB(255, 237, 234, 234),
      body: SafeArea(child: 
        SingleChildScrollView(

          // main column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                  color: MainColor.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(100),
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
                          Row(
                            children: [
                              Text("Welcome $username ",
                                style: const TextStyle(
                                color: Color.fromARGB(255, 254, 253, 253),
                                fontSize: 22,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Image.asset("assets/waving-hand.png",
                            width: 30,
                            fit: BoxFit.cover,
                            )
                            ],
                          ),
                        ],
                      ), 
                    ),

                    Padding(
                      padding:  const EdgeInsets.all(35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PresentAbsentCard(
                            title: "Presents",
                            total: widget.presentList.length.toDouble(),
                            bgColor: presentColor,
                            bIcon: Icons.perm_contact_cal_rounded,
                            ),
                          
                          PresentAbsentCard(
                            title: "Absents",
                            total: widget.absentList.length.toDouble(),
                            bgColor: absentColor,
                            bIcon: Icons.person_off_rounded,
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // line Chart
              Padding(padding: 
                const EdgeInsets.all(15),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Daily Attendences", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),),

                    const SizedBox(
                      height: 20,
                    ),

                    Chart(
                      absentCategoryTotals: widget.absentList,
                      presentCategoryTotals: widget.presentList,
                     
                    )
                  ],
                ),
              ),
              
              // recent attendence

              Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Recent Absents",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Column(
                      children: [
                       widget.absentList.isEmpty ? const Text("No Absents Yet",
                       style: TextStyle(color: Colors.grey),
                       ):
                       ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.absentList.length,
                        itemBuilder: (context, index){
                          final absent = widget.absentList[index];

                          return AbsentCard(
                            reason: absent.reason,
                            date: absent.date,
                            medical: absent.medical,
                            category: absent.category,
                            time: absent.time
                            );
                        },
                      )
                      ],
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