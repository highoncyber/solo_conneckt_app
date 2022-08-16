import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Controllers/NewsFeedController.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Views/Chat/index.dart';
import 'package:soloconneckt/Views/ForexProfile/pages/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/MainPage/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/profile/index.dart';
import 'package:soloconneckt/Views/NfcSettings/index.dart';
import 'package:soloconneckt/Views/SignUp/index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Views/Chat/Message.dart';
import '../Views/ForexProfile/pages/RegisterForex.dart';
import '../Views/Nfc.dart';
import '../Views/RealEstateProfile/RealEstateProfile/index.dart';
import '../classes/pesonalProfile.dart/userprofile.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  NewsFeedController _newsFeedController = Get.find();

  // String theme = "light";
  String usename = "", email = "", image = "";
  String id = "";
  bool islogin = false;

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("first_name"));
    usename = prefs.getString("user_name")!;
    email = prefs.getString("user_email")!;
    image = prefs.getString("image")!;
    id = prefs.getString("user_id")!;
    // String? islogin2 = prefs.getString("is_logged_in");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState\
    addStringToSF();
    super.initState();
  }
  
  var JsonData;
  List<ProfileDetails> Realuser_item = [];
  List<ProfileDetails> Forexuser_item = [];
  getForexUserDetails() async {
    var url =
        Uri.parse(base_url + ApiUrl.getForexUserDetails(id, "ForexProfile"));
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
        Forexuser_item.add(item);
        // print(users[0].date);
      }
      // ForexAccountCreated = true;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ForexProfileHome()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateForexAccount(
                  isedit: false,
                  id: id,
                  profile: "ForexProfile",
                )),
      );
    }
  }

  getRealUserDetails() async {
    var url =
        Uri.parse(base_url + ApiUrl.getForexUserDetails(id, "RealProfile"));
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
        Realuser_item.add(item);
       
        // print(users[0].date);
      }
      // RealAccountCreated = true;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RealProfileHome(
                )),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateForexAccount(
                  isedit: false,
                  id: id,
                  profile: "RealProfile",
                )),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);
    print(image);
    //  gettheme();
    var whichMode = mode.brightness;
    if (whichMode == Brightness.light) {
      _newsFeedController.theme.value = "Light";
      _newsFeedController.isSwitched.value = true;
    } else {
      _newsFeedController.theme.value = "Dark";
      _newsFeedController.isSwitched.value = false;
    }

    print(whichMode);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: whichMode == Brightness.light
                  ? AssetImage(
                      "assets/images/whitelogo.png",
                    )
                  : AssetImage(
                      "assets/images/navbardarklogo.png",
                    )),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 550,
      width: 220,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            width: 2),
                        image: image != null
                            ? DecorationImage(
                                image: NetworkImage(imageUrlUser + image),
                                fit: BoxFit.cover)
                            : null,
                        shape: BoxShape.circle),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.0, bottom: 15),
                    child: Text(
                      usename,
                      style: ThemeHelper()
                          .TextStyleMethod1(12, context, FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.invert_colors),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Theme",
                      style: ThemeHelper()
                          .TextStyleMethod1(16, context, FontWeight.w600),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Obx(
                          () => Text(
                            _newsFeedController.theme.value,
                            style: ThemeHelper().TextStyleMethod1(
                                10, context, FontWeight.normal),
                          ),
                        ),
                        Obx(
                          () => FlutterSwitch(
                            width: 48,
                            height: 25,
                            showOnOff: false,
                            activeColor: Colors.black,
                            inactiveColor: Colors.white,
                            activeToggleColor: Colors.white,
                            toggleColor: Colors.black,
                            value: _newsFeedController.isSwitched.value,
                            onToggle: (val) {
                              if (Get.isDarkMode) {
                                _newsFeedController.theme.value = "Light";
                                Get.changeThemeMode(ThemeMode.light);
                              } else {
                                _newsFeedController.theme.value = "Dark";
                                Get.changeThemeMode(ThemeMode.dark);
                              }
                              _newsFeedController.isSwitched.value = val;
                              // setState(() {
                              //   isSwitched = val;
                              // });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Palette.secondaryColor,
                  height: 3,
                )
              ],
            ),
          ),
          RowWidget(
            text: "Notifications",
            icon: Icon(Icons.notifications_active),
            ontap: () {
              _newsFeedController.isDrawerOpen.value = false;
            },
          ),
          RowWidget(
            text: "Messages",
            icon: Icon(Icons.chat),
            ontap: () {
               _newsFeedController.isDrawerOpen.value = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Message(
                          id: id,
                        )),
              );
            },
          ),
          RowWidget(
            text: "NFC",
            icon: Icon(Icons.nfc_rounded),
            ontap: () {
               _newsFeedController.isDrawerOpen.value = false;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileSetting()),
              );
            },
          ),
          RowWidget(
            text: "NFC Dashboard",
            icon: Icon(Icons.dashboard),
            ontap: () {
              //  _newsFeedController.isDrawerOpen.value = false;
              if (_newsFeedController.personalProfile.value) {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NFCMainPage(
                            profiletype: "PersonalProfile",
                          )),
                );
              } else if (_newsFeedController.forexProfile.value) {
                 getForexUserDetails();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ForexProfileHome()),
                // );
              } else {
                getRealUserDetails();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RealProfileHome()),
                // );
              }
            },
          ),
          RowWidget(
            text: "Shop Now",
            icon: Icon(Icons.shopping_bag_rounded),
            ontap: () async {
               _newsFeedController.isDrawerOpen.value = false;
              var url = 'https://www.soloconneckt.com';

              // ignore: deprecated_member_use
              if (await canLaunch(url)) {
                await launch(
                  url,
                  universalLinksOnly: true,
                );
              } else {
                throw 'There was a problem to open the url: $url';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                 _newsFeedController.isDrawerOpen.value = false;
                ProgressDialog dialog = new ProgressDialog(context);
                dialog.style(message: 'Please wait...');
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                await dialog.hide();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SignUp()),
                    (route) => false);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Sign out",
                    style: ThemeHelper().TextStyleMethod2(
                        16, context, FontWeight.w600, Colors.red),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RowWidget extends StatelessWidget {
  String text;
  Icon icon;
  Function ontap;
  RowWidget({
    required this.text,
    required this.icon,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              ontap();
            },
            child: Row(
              children: [
                icon,
                SizedBox(
                  width: 15,
                ),
                Text(
                  text,
                  style: ThemeHelper()
                      .TextStyleMethod1(16, context, FontWeight.w600),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: Palette.secondaryColor,
            height: 3,
          )
        ],
      ),
    );
  }
}
