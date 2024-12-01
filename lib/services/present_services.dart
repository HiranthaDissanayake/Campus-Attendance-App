import 'dart:convert';

import 'package:attendenz/models/subjectCategory.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PresentServices {
  // presents list
  List<Subject> presentsList = [];

  // Define the key for storing presents in shared pref
    static const String _presentKey = 'presents';

  // Save the presents to shared pref
  Future<void> savePresents(Subject subject, BuildContext context) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List <String>? existingSubject = prefs.getStringList(_presentKey);

      // convert the existing subjects to a list of subject object
      List<Subject> existingSubjectsObjects = [];

      if(existingSubject != null){
        existingSubjectsObjects = existingSubject
          .map((e) => Subject.fromJSON(json.decode(e)))
          .toList();
      }

      // add the new subject to the list
      existingSubjectsObjects.add(subject);

      // convert the list of subject objects back to a list of strings
      List<String> updatedSubjects = existingSubjectsObjects.map((e)=> json.encode(e.toJSON())).toList();

      // save the updated list of presents to shared pref
      await prefs.setStringList(_presentKey, updatedSubjects);

      //Show message
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your attendense is marked successfully!"),
        duration: Duration(seconds: 2),
        ),
      );
    }
      

    }catch(error){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error on adding attendence !"),
        duration: Duration(seconds: 2),
        ),
      );
    }
    }
  }

  //Load the presents from shared pref

  Future <List<Subject>> loadPresents () async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingSubject = pref.getStringList(_presentKey);

    // convert the existing subjects to a list of subject objects
    List<Subject> loadSubjects = [];
    if(existingSubject != null){
      loadSubjects = existingSubject
          .map((e)=> Subject.fromJSON(json.decode(e)))
          .toList();
    }

    return loadSubjects;
  }

}