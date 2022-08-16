import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/CreateAccount/eula.dart';
import 'package:soloconneckt/Views/CreateAccount/terms.dart';
import 'package:soloconneckt/Views/phoneNumber/index.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/Widgets/textFeildDecoration.dart';

import '../../Services/constants.dart';
import '../../Styles/ThemeHelper.dart';
import '../../Widgets/ShowResponse.dart';
import '../SignUp/index.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
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

  var JsonData;

  checkEmail(email) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var url = Uri.parse(base_url + ApiUrl.checkEmail(email));
    print(url);
    var response = await http.get(url);
    setState(() {
      JsonData = json.decode(response.body);
    });

    print(JsonData[0]["code"]);
    if (JsonData[0]["code"] == 1)  {
      await dialog.hide();
      ShowResponse(
          "An account has already been created from this email", context);
    } else {
      await dialog.hide();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Phonenumber(
                  email: emailController.text,
                  name: nameController.text,
                  password: passwordController.text,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                Hero(
                    tag: "pic",
                    child: Image.asset(
                      "assets/images/blacklogo.png",
                      width: 150,
                      height: 150,
                    )),
                Text(
                  "Create an Account",
                  style: ThemeHelper().TextStyleMethod2(
                      20, context, FontWeight.w600, Colors.black),
                ),
                Text(
                  "Sign up now to started with an account",
                  style: ThemeHelper().TextStyleMethod2(
                      12, context, FontWeight.normal, Colors.black),
                ),
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
                        "Password*",
                        style: ThemeHelper().TextStyleMethod2(
                            12, context, FontWeight.w600, Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        obscureText: _passwordVisible,
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
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1)),
                            enabledBorder: const UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                    color: Palette.dimGrey, width: 4))),
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
                        "Confirm Password*",
                        style: ThemeHelper().TextStyleMethod2(
                            12, context, FontWeight.w600, Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        obscureText: _passwordVisible1,
                        controller: password2Controller,
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
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(15.0),
                            // ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1)),
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EULA()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    Theme.of(context).colorScheme.background),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          "EULA",
                          style: ThemeHelper().TextStyleMethod2(
                              15,
                              context,
                              FontWeight.w600,
                              Theme.of(context).colorScheme.background),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermsAndConditions()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    Theme.of(context).colorScheme.background),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          "Privacy Policy",
                          style: ThemeHelper().TextStyleMethod2(
                              15,
                              context,
                              FontWeight.w600,
                              Theme.of(context).colorScheme.background),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FormField<bool>(
                  builder: (state) {
                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                                checkColor: Colors.white,
                                fillColor: MaterialStateProperty.all(
                                    Palette.mediumGrey),
                                value: checkboxValue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onChanged: (value) {
                                  setState(() {
                                    checkboxValue = value!;
                                    state.didChange(value);
                                  });
                                }),
                            Expanded(
                              child: Text(
                                "By registering on our Solo Conneckt app you are agreed to our Privacy Policy and EULA policy. For more information please check our EULA policy, Terms & Conditions above. If any question contact us on Email: Decarlos.sanders@gmail.com",
                                style: ThemeHelper().TextStyleMethod2(12,
                                    context, FontWeight.w700, Palette.darkGrey),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            state.errorText ?? '',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontSize: 10,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  validator: (value) {
                    if (!checkboxValue) {
                      return 'You need to accept EULA and Privacy Policy';
                    } else {
                      return null;
                    }
                  },
                ),
                Visibility(
                  visible: passGuide,
                  child: Text(
                    "The password must contain at least 8 characters and the password must contain upper case letters, lowercase letters, numbers and special characters like ! @ \$ Etc.",
                    style: ThemeHelper().TextStyleMethod2(
                        12, context, FontWeight.w700, Palette.darkGrey),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (password2Controller.text == passwordController.text) {
                        checkEmail(emailController.text);
                      } else {
                        ShowResponse("password does not match", context);
                      }
                    }
                  },
                  child: Container(
                    height: 58,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Text(
                        "Next",
                        style: ThemeHelper().TextStyleMethod2(
                            16, context, FontWeight.bold, Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Text(
                        "Or Sign In?",
                        style: ThemeHelper().TextStyleMethod2(
                            13, context, FontWeight.w700, Palette.darkGrey),
                      ),
                    ),
                  ],
                ),
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
