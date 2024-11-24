import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  // method to store the user details in shared preferences

  static Future <void> storeUserDetails(
    {
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context
    }) async{

   

    // if the users password and conf password are same then store username and email

    try{

       // check whether the user password and the confirm password are the same
      if(password != confirmPassword){
        //show a message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password and Confirm Password do not match"),
            ),
        );

        return;
    }

      // create an instance from shared pref
      SharedPreferences pref = await SharedPreferences.getInstance();

      // store the user name and email as key value pairs
      await pref.setString("username", userName);
      await pref.setString("email", email);

      // show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User Details stored successfull"))
      );

    }catch(err){
      err.toString();
    }

  }
}