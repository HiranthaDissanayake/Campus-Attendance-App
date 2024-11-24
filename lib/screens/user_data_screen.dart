import 'package:attendenz/constants/colors.dart';
import 'package:attendenz/screens/main_screen.dart';
import 'package:attendenz/services/user_services.dart';
import 'package:attendenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {

  // for the check box
  bool _rememberMe = false;

  // form key for the form validations
  final _formKey = GlobalKey<FormState>();

  // controller for the text from feilds
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(child: 
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
            const Text("Personal Details",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500
            ),
            ),
            const SizedBox(
              height: 30,
            ),
            
            //Form

            Form(
              key: _formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // form feild for the user name
                TextFormField(
                  controller: _userNameController,
                  validator: (value) {
                    //check whether the user entered a valid user name
                    if(value!.isEmpty){
                      return "Please Enter a valid Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    contentPadding: const EdgeInsets.all(20)
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // form feild for the user email
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    //check whether the user entered a valid user email
                    if(value!.isEmpty){
                      return "Please Enter a valid Email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    contentPadding: const EdgeInsets.all(20)
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // form feild for the user password
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    //check whether the user entered a valid user password
                    if(value!.isEmpty){
                      return "Please Enter a valid Password";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    contentPadding: const EdgeInsets.all(20)
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // form feild for the user confirm password
                TextFormField(
                  controller: _confirmPasswordController,
                  validator: (value) {
                    //check whether the same password
                    if(value!.isEmpty){
                      return "Please Enter the same password";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    contentPadding: const EdgeInsets.all(20)
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                Row(
                  children: [
                    const Text("Remember me for the next time",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                    ),
                    ),

                    Expanded(child: CheckboxListTile(
                      activeColor: MainColor,
                      value: _rememberMe,
                      onChanged: (value){
                        setState(() {
                          _rememberMe = value!;
                        });
                      }
                      )),    
                  ],
                ),

                const SizedBox(
                        height: 30,
                      ),

                      // submit button
                      GestureDetector(
                        onTap: () async{
                          if(_formKey.currentState!.validate()){
                            // form is valid, process data

                            String userName = _userNameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String confirmPassword = _confirmPasswordController.text;

                            // save the user details in the device storage
                            await UserServices.storeUserDetails(
                              userName: userName,
                              email: email,
                              password: password,
                              confirmPassword: confirmPassword,
                              context: context
                              );

                              if (password != confirmPassword){
                                return;
                              }else{
                                // navigate to the main screen
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return const MainScreen();
                              },));
                              }
                              
                          }
                        },
                        child: const CustomButton(
                          buttonName: "Next",
                          buttonColor: MainColor),
                        )
              ],
            ))
          ],
            ),
          )
        ),
      ),
    );
    
  }
}