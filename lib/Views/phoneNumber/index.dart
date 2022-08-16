import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:soloconneckt/Views/CreateAccount/ProfilePicture.dart';
import 'package:soloconneckt/Views/VerificationPage/index.dart';
import 'package:soloconneckt/Widgets/textFeildDecoration.dart';

import '../../Styles/ThemeHelper.dart';
import '../../Styles/palette.dart';

class Phonenumber extends StatelessWidget {
  String email, password, name;
  Phonenumber(
      {required this.email, required this.name, required this.password, key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberController = new TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
                            "Phone Number*",
                            style: ThemeHelper().TextStyleMethod2(
                                12, context, FontWeight.w600, Colors.black),
                          ),
                          IntlPhoneField(
                            decoration: TextFormFeildDecoration(),
                            controller: numberController,
                            dropdownTextStyle: TextStyle(color: Colors.black),
                            // validator: (value) {
                            //   if (value != null && value.trim().length < 11) {
                            //     return 'The number must contain 11 digits.';
                            //   }

                            //   return null;
                            // },
                            keyboardType: TextInputType.number,
                             style: ThemeHelper().TextStyleMethod2(
                                16, context, FontWeight.bold, Palette.Black),
                            initialCountryCode:
                                'PK', //default contry code, NP for Nepal
                            onChanged: (phone) {
                              //when phone number country code is changed
                              print(phone.completeNumber); //get complete number
                              print(phone.countryCode); // get country code only
                              print(phone.number); // only phone number
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Any Login Problems?",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              decoration: TextDecoration.underline,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Palette.blue),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePicture(
                                      email: email,
                                      name: name,
                                      password: password,
                                      number: numberController.text,
                                    )),
                          );
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
                            "Next",
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
