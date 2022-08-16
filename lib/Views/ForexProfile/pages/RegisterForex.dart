import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/CreateAccount/eula.dart';
import 'package:soloconneckt/Views/CreateAccount/terms.dart';
import 'package:soloconneckt/Views/ForexProfile/pages/ProfilePicture.dart';
import 'package:soloconneckt/Views/phoneNumber/index.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/Widgets/textFeildDecoration.dart';

import '../../../classes/pesonalProfile.dart/userprofile.dart';

class CreateForexAccount extends StatefulWidget {
  bool isedit;
  String id,profile;
   CreateForexAccount({Key? key,required this.isedit,required this.id,required this.profile}) : super(key: key);

  @override
  State<CreateForexAccount> createState() => _CreateForexAccountState();
}

class _CreateForexAccountState extends State<CreateForexAccount> {

  
  final sloganController = new TextEditingController();
  final workAtController = new TextEditingController();
  final professionController = new TextEditingController();
  final nameController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();




    var JsonData;
  List<ProfileDetails> user_item = [];
  getUserDetails() async {
    var url = Uri.parse(
        base_url + ApiUrl.getForexUserDetails(widget.id, "ForexProfile"));
    print(url);
    // print("idd " + id);
    var response = await http.get(url);
    JsonData = json.decode(response.body);
    print(response.body);
    if (JsonData[0]["code"] != 0) {
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        ProfileDetails item = ProfileDetails(
          d["profile_name"],
          d["profile_slogan"],
          d["profession"],
          d["worksAt"],
          d["profile_image"],
        );
        user_item.add(item);
        // print(users[0].date);
      }
      sloganController.text=user_item[0].profile_slogan;
      nameController.text=user_item[0].profile_name;
      professionController.text=user_item[0].profession;
      workAtController.text=user_item[0].worksAt;

    } 
    print(user_item.length);
    setState(() {});
  }

    @override
  void initState() {
    if(widget.isedit){
      getUserDetails();
    }
    // TODO: implement initState
    super.initState();
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
                  height: 25,
                ),
                Text(
                  "Create an Account",
                  style: ThemeHelper().TextStyleMethod2(
                      20, context, FontWeight.w600, Colors.black),
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
                        "Profession*",
                        style: ThemeHelper().TextStyleMethod2(
                            12, context, FontWeight.w600, Colors.black),
                      ),
                      TextFormField(
                        controller: professionController,
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
                        "Works At*",
                        style: ThemeHelper().TextStyleMethod2(
                            12, context, FontWeight.w600, Colors.black),
                      ),
                      TextFormField(
                        controller: workAtController,
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
                        "Slogan*",
                        style: ThemeHelper().TextStyleMethod2(
                            12, context, FontWeight.w600, Colors.black),
                      ),
                      TextFormField(
                        controller: sloganController,
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
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePicture(
                              profile: widget.profile,
                              image: widget.isedit?user_item[0].profile_image:"",
                                  name: nameController.text,
                                  profession: professionController.text,
                                  slogan: sloganController.text,
                                  workat: workAtController.text,
                                  isedit: widget.isedit,
                                )),
                      );
                      // if (password2Controller.text == passwordController.text) {
                      //   checkEmail(emailController.text);
                      // } else {
                      //   ShowResponse("password does not match", context);
                      // }
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
              ],
            ),
          )),
        ),
      ),
    );
  }
}
