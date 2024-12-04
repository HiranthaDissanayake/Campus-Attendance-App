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

  // delete the present card
  Future <void> deletePresent(int id, BuildContext context) async{
    try{

      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingPresents = pref.getStringList(_presentKey);

      // convert the existing presents to a list of absent objects
      List <Subject> existingPresentObject = [];

      if(existingPresents != null){
       existingPresentObject = existingPresents
          .map((e) => Subject.fromJSON(json.decode(e)))
          .toList();
      }

      // Remove the present with the specified id from the list
      existingPresentObject.removeWhere((present) => present.id == id);

      // convert the list of present objects back to a list of strings
      List<String> updatedPresents = existingPresentObject
            .map((e) => json.encode(e.toJSON()))
            .toList();

      // save the updated present list
      await pref.setStringList(_presentKey, updatedPresents);

      // show snackbar
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Present data deleted successfully!"),
          duration: Duration(seconds: 2),
          )
        );
      }

    }catch(error){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error deleting Present details"),
          duration: Duration(seconds: 2),
          )
        );
      }
    }
  }

}