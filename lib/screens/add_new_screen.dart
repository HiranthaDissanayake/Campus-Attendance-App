import 'package:attendenz/constants/colors.dart';
import 'package:attendenz/models/subjectCategory.dart';
import 'package:attendenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {

  //state to track the prests or absents
  int _selectedMethod = 0;
  Subjectcategory _subjectCategory = Subjectcategory.subject1;
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? presentColor : absentColor,
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height* 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _selectedMethod = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMethod == 0 ? presentColor : Colors.white,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                            child: Text("Presents",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _selectedMethod == 0 ? Colors.white : Colors.black,
                            ),),
                          ),
                        ),
                      ),
                
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _selectedMethod = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMethod == 1 ? absentColor : Colors.white,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                            child: Text("Absents",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _selectedMethod == 1 ? Colors.white : Colors.black,
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      
              // Total feild
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: _selectedMethod == 0 ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("How is Today ? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                      ),
                      ),
                  
                      TextField(
                        decoration: InputDecoration(
                          hintText: "your idea...",
                          border: InputBorder.none
                        ),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ) : const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("What is the Reason ? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                      ),
                      ),
                  
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Reason...",
                          border: InputBorder.none
                        ),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              ),
      
              // user data form
              Container(
                height: MediaQuery.of(context).size.height*0.6,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.3,
                  ),
                decoration: const BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                  )
                ),
      
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    child: Column(
                      children: [
                        // category selector dropdown
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20
                            )
                          ),
                          items: Subjectcategory.values.map((category){
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category.name),
                            );
                            }).toList(),
                          
                          value: _subjectCategory,
                          onChanged: (value){
                            setState(() {
                              _subjectCategory = value as Subjectcategory;
                            });
                          }
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //title field
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: "Description",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)
                            )
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //date picker
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                showDatePicker(context: context,
                                 initialDate: DateTime.now(),
                                 firstDate: DateTime(2023),
                                 lastDate: DateTime(2050),
                                 ).then((value) =>{
                                    if(value != null){
                                      setState(() {
                                        _selectedDate = value;
                                      })
                                    }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: MainColor,
                                ),
                              
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 15
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_month_outlined,color: Colors.white,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Select Date", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20
                              ),
                              child: Text(
                                DateFormat.yMMMd().format(_selectedDate),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            )

                          ],
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                         //time picker
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now()
                                  ).then((value){
                                    if(value!= null){
                                      setState(() {
                                       _selectedTime = DateTime(
                                        _selectedDate.year,
                                        _selectedDate.month,
                                        _selectedDate.day,
                                        value.hour,
                                        value.minute
                                      ); 
                                      });
                                      
                                    }
                                  });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color.fromARGB(255, 171, 100, 15),
                                ),
                              
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 15
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.timer,color: Colors.white,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Select Time", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20
                              ),
                              child: Text(
                                DateFormat.jm().format(_selectedTime),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            )

                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        const Divider(
                          color: Color.fromARGB(255, 217, 203, 203),
                          thickness: 5,
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        CustomButton(
                          buttonName: "ADD",
                          buttonColor: _selectedMethod == 0 ? presentColor : absentColor,
                        )
                      ],
                    ),
                  ),
                ),
              )
      
            ],
      
      
          ),
        ),
      )),
    );
  }
}