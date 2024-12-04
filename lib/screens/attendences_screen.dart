import 'package:attendenz/constants/colors.dart';
import 'package:attendenz/models/subjectCategory.dart';
import 'package:attendenz/widgets/absent_card.dart';
import 'package:flutter/material.dart';

class AttendencesScreen extends StatefulWidget {
  final List<Subject> absentList;
  final void Function(Subject) onDismissedAbsent;

  const AttendencesScreen({
    super.key,
    required this.absentList,
    required this.onDismissedAbsent
    });

  @override
  State<AttendencesScreen> createState() => _AttendencesScreenState();
}

class _AttendencesScreenState extends State<AttendencesScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("See your attendence report",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: MainColor
              ),
              ),

              const SizedBox(
                height: 20,
              ),

              const Text("Absents",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: absentColor
              ),
              ),

              const SizedBox(
                height: 20,
              ),

              // show all the absents
              SizedBox(
                height: MediaQuery.of(context).size.height*0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.absentList.length,
                        itemBuilder: (context, index){
                          final absent = widget.absentList[index];

                          return Dismissible(
                            key: ValueKey(absent),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.onDismissedAbsent(absent);
                              });
                            },
                            child: AbsentCard(
                              reason: absent.reason,
                              date: absent.date,
                              medical: absent.medical,
                              category: absent.category,
                              time: absent.time
                              ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          )
      
      ),
    );
  }
}