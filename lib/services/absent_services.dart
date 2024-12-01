import 'dart:convert';

import 'package:attendenz/models/subjectCategory.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AbsentServices{

  // define the key for storing absents in shared pref
  static const String _absentKey = "absent";

  // save the absent to shared pref

  Future <void> saveAbsent (Subject absent , BuildContext context) async{
   
   try{
     SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? existingAbsents = prefs.getStringList(_absentKey);

    // convert the existing absents to a list of absent objects
    List<Subject> existingAbsentObject = [];

    if(existingAbsents != null){
      existingAbsentObject = 
          existingAbsents.map((e)=> Subject.fromJSON(json.decode(e))).toList();
    }

    // add the new absent to the list
    existingAbsentObject.add(absent);

    // convert the list of absent objects back to alist of strings
    List<String> updatedAbsent =
        existingAbsentObject.map((e)=> json.encode(e.toJSON())).toList();

    // save the updated list of absents to shared pref
    await prefs.setStringList(_absentKey, updatedAbsent);

    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Your attendence is marked successfuly!"),
      duration: Duration(seconds: 2),)
    );
    }
    
   }catch(error){
      if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Something went Wrong"),
      duration: Duration(seconds: 2),)
    );
   }
  }

  }

  //Load the absent from shared pref
  Future <List<Subject>> loadAbsents() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingAbsents = pref.getStringList(_absentKey);

    // convert the existing absents to a list of absent objects
    List<Subject> loadedAbsents = [];
    if(existingAbsents != null){
      loadedAbsents =
         existingAbsents.map((e) => Subject.fromJSON(json.decode(e))).toList();
    }

    return loadedAbsents;
  }
}