import 'package:attendenz/constants/colors.dart';
import 'package:flutter/material.dart';

class Frontpage extends StatelessWidget {
  const Frontpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/image1.jpg" ,
         width: 200, 
         fit: BoxFit.cover,
         ),

         const SizedBox(
          height: 20,
         ),

         const Center(
          child: Text("Attendenz",
           style: TextStyle(
            fontSize: 40,
            color: MainColor,
            fontWeight: FontWeight.bold
           ),),
         )
      ],
    );
  }
}