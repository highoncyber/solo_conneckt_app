import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Controllers/NewsFeedController.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/RealEstateProfile/RealEstateProfile/index.dart';
import 'package:http/http.dart' as http;
import '../../Services/constants.dart';
import '../../classes/pesonalProfile.dart/userprofile.dart';
import '../ForexProfile/pages/RegisterForex.dart';
import '../ForexProfile/pages/index.dart';
import '../ForexProfile/pages/profile.dart';
import '../NfcDashboard/pages/MainPage/index.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  String id = "";
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("user_id")!;
    String? islogin = prefs.getString("is_logged_in");
    setState(() {});
    // getForexUserDetails();
    // getRealUserDetails();
  }

  @override
  void initState() {
    addStringToSF();
    // TODO: implement initState
    super.initState();
  }

  bool ForexAccountCreated = false;
  bool RealAccountCreated = false;

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
      ForexAccountCreated = true;
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
      RealAccountCreated = true;
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
    var whichMode = mode.brightness;
    NewsFeedController _newsFeedController = Get.find();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text(
          "SOLO CONNECKT",
          style: ThemeHelper().TextStyleMethod2(20, context, FontWeight.w600,
              Theme.of(context).colorScheme.primaryVariant),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Build your profile(s)",
                  style: ThemeHelper()
                      .TextStyleMethod1(14, context, FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          whichMode == Brightness.light
              ? Image.asset(
                  "assets/images/blacklogo.png",
                  width: 150,
                  height: 150,
                )
              : Image.asset(
                  "assets/images/goldenLogo.png",
                  width: 150,
                  height: 150,
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              color: Palette.secondaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Obx(
                      () => FlutterSwitch(
                        // disabled: true,
                        width: 48,
                        height: 25,
                        showOnOff: false,
                        activeColor: Palette.DarkGolden,
                        inactiveColor:
                            Theme.of(context).colorScheme.primaryVariant,
                        activeToggleColor: Theme.of(context).backgroundColor,
                        toggleColor: Theme.of(context).backgroundColor,
                        value: _newsFeedController.realEstateProfile.value,
                        onToggle: (val) {
                          _newsFeedController.realEstateProfile.value = val;
                          HttpService().editActiveStatus(id, "2", context, ApiUrl.editActiveUser);
                          if (val == true) {
                            _newsFeedController.forexProfile.value = !val;
                            _newsFeedController.personalProfile.value = !val;
                            
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => FlutterSwitch(
                        // disabled: true,
                        width: 48,
                        height: 25,
                        showOnOff: false,
                        activeColor: Palette.DarkGolden,
                        inactiveColor:
                            Theme.of(context).colorScheme.primaryVariant,
                        activeToggleColor: Theme.of(context).backgroundColor,
                        toggleColor: Theme.of(context).backgroundColor,
                        value: _newsFeedController.forexProfile.value,
                        onToggle: (val) {
                          _newsFeedController.forexProfile.value = val;
                          HttpService().editActiveStatus(id, "1", context, ApiUrl.editActiveUser);
                          if (val == true) {
                            _newsFeedController.personalProfile.value = !val;
                            _newsFeedController.realEstateProfile.value = !val;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => FlutterSwitch(
                        // disabled: true,
                        width: 48,
                        height: 25,
                        showOnOff: false,
                        activeColor: Palette.DarkGolden,
                        inactiveColor:
                            Theme.of(context).colorScheme.primaryVariant,
                        activeToggleColor: Theme.of(context).backgroundColor,
                        toggleColor: Theme.of(context).backgroundColor,
                        value: _newsFeedController.personalProfile.value,
                        onToggle: (val) {
                          _newsFeedController.personalProfile.value = val;
                          HttpService().editActiveStatus(id, "0", context, ApiUrl.editActiveUser);
                          if (val == true) {
                            _newsFeedController.forexProfile.value = !val;
                            _newsFeedController.realEstateProfile.value = !val;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Real Estate Profile",
                      style: ThemeHelper()
                          .TextStyleMethod1(16, context, FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Forex Profile",
                      style: ThemeHelper()
                          .TextStyleMethod1(16, context, FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Personal Profile",
                      style: ThemeHelper()
                          .TextStyleMethod1(16, context, FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditWidget(ontap: () {
                      if (_newsFeedController.realEstateProfile.value)
                        getRealUserDetails();
                    }),
                    EditWidget(ontap: () {
                      if (_newsFeedController.forexProfile.value)
                        getForexUserDetails();
                    }),
                    EditWidget(ontap: () {
                      if (_newsFeedController.personalProfile.value)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NFCMainPage(profiletype: "PersonalProfile",)),
                        );
                    }),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          whichMode == Brightness.light
              ? Image.asset(
                  "assets/images/Group-4.png",
                  width: 150,
                  height: 150,
                )
              : Image.asset(
                  "assets/images/goldenNfc.png",
                  width: 150,
                  height: 150,
                ),
        ],
      )),
    );
  }
}

class EditWidget extends StatelessWidget {
  Function ontap;
  EditWidget({
    Key? key,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
            height: 40,
            child: Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
          Text(
            "Edit",
            style: ThemeHelper()
                .TextStyleMethod2(14, context, FontWeight.w500, Colors.blue),
          ),
        ],
      ),
    );
  }
}
