import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Views/CreateAccount/ProfilePicture.dart';
import 'package:soloconneckt/Views/SignUp/index.dart';
import 'package:soloconneckt/Views/VerificationPage/index.dart';
import 'package:soloconneckt/Widgets/ShowResponse.dart';
import 'package:soloconneckt/Widgets/textFeildDecoration.dart';
import 'package:http/http.dart' as http;

import '../../Services/constants.dart';
import '../../Styles/ThemeHelper.dart';
import '../../Styles/palette.dart';

class NewPassword extends StatefulWidget {
  String email;
  NewPassword({this.email = "", key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool passGuide = false;
  bool _passwordVisible = true;
  bool _passwordVisible1 = true;
  final passwordController = new TextEditingController();
  final passwordController2 = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 30,
                            ))
                      ],
                    ),
                    Hero(
                        tag: "pic",
                        child: Image.asset(
                          "assets/images/whitelogo.png",
                          width: 300,
                          height: 300,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "New Password*",
                            style: ThemeHelper().TextStyleMethod2(
                                12, context, FontWeight.w600, Colors.black),
                          ),
                          TextFormField(
                            obscureText: _passwordVisible1,
                            controller: passwordController,
                            validator: (value) {
                              if (value!.length < 8) {
                                setState(() {
                                  passGuide = true;
                                });
                                return "Password length must be 8 characters";
                              } else if (isPasswordCompliant(value) == false) {
                                setState(() {
                                  passGuide = true;
                                });
                                return "Please use strong password";
                              } else if (isPasswordCompliant(value)) {
                                setState(() {
                                  passGuide = false;
                                });
                                return null;
                              }
                              // if (value != null && value.trim().length < 3) {
                              //   return 'This field requires a minimum of 3 characters';
                              // }

                              // return null;
                            },
                            style: ThemeHelper().TextStyleMethod2(
                                16, context, FontWeight.bold, Palette.Black),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible1 = !_passwordVisible1;
                                      });
                                    },
                                    icon: Icon(
                                      _passwordVisible1
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    )),
                                contentPadding: EdgeInsets.all(15),
                                filled: true,
                                fillColor: Palette.lightGrey,
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Palette.dimGrey, width: 4))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Confirm Password*",
                            style: ThemeHelper().TextStyleMethod2(
                                12, context, FontWeight.w600, Colors.black),
                          ),
                          TextFormField(
                            obscureText: _passwordVisible,
                            controller: passwordController2,
                            validator: (value) {
                              if (value!.length < 8) {
                                setState(() {
                                  passGuide = true;
                                });
                                return "Password length must be 8 characters";
                              } else if (isPasswordCompliant(value) == false) {
                                setState(() {
                                  passGuide = true;
                                });
                                return "Please use strong password";
                              } else if (isPasswordCompliant(value)) {
                                setState(() {
                                  passGuide = false;
                                });
                                return null;
                              }
                              // if (value != null && value.trim().length < 3) {
                              //   return 'This field requires a minimum of 3 characters';
                              // }

                              // return null;
                            },
                            style: ThemeHelper().TextStyleMethod2(
                                16, context, FontWeight.bold, Palette.Black),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    )),
                                contentPadding: EdgeInsets.all(15),
                                filled: true,
                                fillColor: Palette.lightGrey,
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Palette.dimGrey, width: 4))),
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: <Widget>[
                    //     Text(
                    //       "Any Login Problems?",
                    //       style: TextStyle(
                    //           fontFamily: "Montserrat",
                    //           decoration: TextDecoration.underline,
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.bold,
                    //           color: Palette.blue),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (passwordController2.text ==
                              passwordController.text) {
                            ProgressDialog dialog = new ProgressDialog(context);
                            dialog.style(message: 'Please wait...');
                            await dialog.show();
                            var url =
                                Uri.parse(base_url + "/User/editPassword.php");
                            print(url);
                            var request = http.MultipartRequest('POST', url);
                            request.fields['user_password'] =
                                passwordController.text;
                            request.fields['user_email'] = widget.email;
                            request.fields['auth_key'] = auth_key;

                            var response =
                                await request.send().then((result) async {
                              http.Response.fromStream(result)
                                  .then((response) async {
                                // ShowResponse(response.body);
                                var data = json.decode(response.body);
                                var code = data[0]['code'];
                                if (code == 1) {
                                  await dialog.hide();
                                  ShowResponse(
                                      "New Password should not be the same as before",
                                      context);
                                } else if (code == 3) {
                                  await dialog.hide();
                                  ShowResponse("Password changed successfully!",
                                      context);
                                       addStringToSF(data);
                                  Navigator.pushAndRemoveUntil<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          SignUp(),
                                    ),
                                    (route) =>
                                        false, //if you want to disable back feature set to false
                                  );
                                } else if (code == 0) {
                                  await dialog.hide();
                                  ShowResponse(
                                      "Email does not exist!", context);
                                } else {
                                  await dialog.hide();
                                  ShowResponse(
                                      "Something went wrong. Recheck you email and internet connectivity.",
                                      context);
                                }
                              });
                            });
                          } else {
                            ShowResponse("password does not match", context);
                          }
                        }
                      },
                      child: Container(
                        height: 58,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Palette.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: Text(
                            "Change Password",
                            style: ThemeHelper().TextStyleMethod2(
                                16, context, FontWeight.bold, Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
