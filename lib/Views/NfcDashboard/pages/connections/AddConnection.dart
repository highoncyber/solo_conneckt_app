import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/CreateAccount/eula.dart';
import 'package:soloconneckt/Views/CreateAccount/terms.dart';
import 'package:soloconneckt/Views/phoneNumber/index.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/Widgets/textFeildDecoration.dart';


class AddConnection extends StatefulWidget {
  const AddConnection({Key? key}) : super(key: key);

  @override
  State<AddConnection> createState() => _AddConnectionState();
}

class _AddConnectionState extends State<AddConnection> {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final password2Controller = new TextEditingController();
  final nameController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool checkboxValue = false;
  bool passGuide = false;
  bool _passwordVisible = true;
  bool _passwordVisible1 = true;

  bool isPasswordCompliant(String password, [int minLength = 8]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length >= minLength;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
  }

  // var JsonData;

  // checkEmail(email) async {
  //   ProgressDialog dialog = new ProgressDialog(context);
  //   dialog.style(message: 'Please wait...');
  //   await dialog.show();
  //   var url = Uri.parse(base_url + ApiUrl.checkEmail(email));
  //   print(url);
  //   var response = await http.get(url);
  //   setState(() {
  //     JsonData = json.decode(response.body);
  //   });

  //   print(JsonData[0]["code"]);
  //   if (JsonData[0]["code"] == 1)  {
  //     await dialog.hide();
  //     ShowResponse(
  //         "An account has already been created from this email", context);
  //   } else {
  //     await dialog.hide();
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => Phonenumber(
  //                 email: emailController.text,
  //                 name: nameController.text,
  //                 password: passwordController.text,
  //               )),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "SOLO CONNECKT",
          style: ThemeHelper().TextStyleMethod2(20, context, FontWeight.w600,
              Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color:Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full Name*",
                        style: ThemeHelper().TextStyleMethod2(
                            12, context, FontWeight.w600, Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value != null && value.trim().length < 3) {
                            return 'This field requires a minimum of 3 characters';
                          }

                          return null;
                        },
                        style: ThemeHelper().TextStyleMethod2(
                            16, context, FontWeight.bold, Palette.Black),
                        decoration: TextFormFeildDecoration(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Address*",
                        style: ThemeHelper().TextStyleMethod2(
                            12, context, FontWeight.w600, Colors.black),
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter a valid email address";
                          } else if (RegExp(r'\S+@\S+\.\S+').hasMatch(val) ==
                              false) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                        style: ThemeHelper().TextStyleMethod2(
                            16, context, FontWeight.bold, Palette.Black),
                        decoration: TextFormFeildDecoration(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title*",
                        style: ThemeHelper().TextStyleMethod2(
                            12, context, FontWeight.w600, Colors.black),
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter a valid email address";
                          } else if (RegExp(r'\S+@\S+\.\S+').hasMatch(val) ==
                              false) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                        style: ThemeHelper().TextStyleMethod2(
                            16, context, FontWeight.bold, Palette.Black),
                        decoration: TextFormFeildDecoration(),
                      ),
                    ],
                  ),
                ),
               
                SizedBox(
                  height: 10,
                ),
                
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (password2Controller.text == passwordController.text) {
                        // checkEmail(emailController.text);
                      } else {
                        // ShowResponse("password does not match", context);
                      }
                    }
                  },
                  child: Container(
                    height: 58,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Text(
                        "Create",
                        style: ThemeHelper().TextStyleMethod2(
                            16, context, FontWeight.bold, Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => SignUp()),
                //         );
                //       },
                //       child: Text(
                //         "Or Sign In?",
                //         style: ThemeHelper().TextStyleMethod2(
                //             13, context, FontWeight.w700, Palette.darkGrey),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
                     