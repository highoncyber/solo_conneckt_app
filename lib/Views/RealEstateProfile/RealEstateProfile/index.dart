import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/Views/ForexProfile/pages/RegisterForex.dart';
import 'package:soloconneckt/Views/ForexProfile/pages/index.dart';
import 'package:soloconneckt/Views/ForexProfile/widgets/ApplinksButton.dart';
import 'package:soloconneckt/Views/ForexProfile/widgets/ApplinksWidget.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/apps/index.dart';
import 'package:soloconneckt/Views/Profile/editProfile.dart';
import 'package:soloconneckt/Views/RealEstateProfile/RealEstateProfile/profile.dart';
import 'package:soloconneckt/classes/pesonalProfile.dart/userprofile.dart';

import '../../../../Widgets/IconList.dart';

class RealProfileHome extends StatefulWidget {
  const RealProfileHome({Key? key}) : super(key: key);

  @override
  State<RealProfileHome> createState() => _FRealProfileHomeState();
}

class _FRealProfileHomeState extends State<RealProfileHome> {
  String usename = "", email = "", image = "", id = "";
  String islogin = "No";
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usename = prefs.getString("user_name")!;
    email = prefs.getString("user_email")!;
    image = prefs.getString("image")!;
    id = prefs.getString("user_id")!;
    String? islogin = prefs.getString("is_logged_in");
    setState(() {});
    getCardDetails();
    getUserDetails();
  }

  bool AccountCreated = false;

  var JsonData;
  List<ProfileDetails> user_item = [];
  getUserDetails() async {
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
        user_item.add(item);
        // print(users[0].date);
      }
      AccountCreated = true;
    }
    print(user_item.length);
    setState(() {});
  }

  List<PerosnalProfile_item> profile_item = [];
  bool isloading1 = true;
  getCardDetails() async {
    var url;
    if (id != "")
      url = Uri.parse(base_url +
          ApiUrl.getPersnalProfile(
            id,
            "false",
            "",
            "RealProfile",
          ));
    print(url);
    // print("idd " + id);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(response.body);
    profile_item.clear();
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        PerosnalProfile_item item = PerosnalProfile_item(
          d["title"],
          d["icon"],
          d["order_by_id"],
          d["url"],
          d["id"],
          d["active"],
        );
        profile_item.add(item);
        // print(users[0].date);
      }

    print(profile_item.length);
    isloading1 = false;
    setState(() {});
  }

  @override
  void initState() {
    addStringToSF();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RealProfileWidget(
                        id: id,
                      )),
            );
          },
          icon: Icon(
            Icons.remove_red_eye,
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConnectionScreen()),
              );
            },
            icon: Icon(
              Icons.people_alt_sharp,
              color: Theme.of(context).colorScheme.primaryVariant,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: AccountCreated
            ? Container(
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryVariant,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  // margin: EdgeInsets.all(2),
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              user_item[0].profile_image != null
                                                  ? imageUrlUser +
                                                      user_item[0].profile_image
                                                  : defaultUser),
                                          fit: BoxFit.cover),
                                      border: Border.all(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          width: 2),
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Text(
                                        user_item[0].profile_name,
                                        style: ThemeHelper().TextStyleMethod2(
                                            16,
                                            context,
                                            FontWeight.bold,
                                            Theme.of(context).backgroundColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () async {
                                  final RouteResponse = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateForexAccount(
                                              isedit: true,
                                              id: id,
                                              profile: "RealProfile",
                                            )),
                                  );
                                  if (RouteResponse == "refresh") {
                                    addStringToSF();
                                  }
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).backgroundColor,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isloading1 == true
                      ? CircularProgressIndicator()
                      : Expanded(
                          child: ListView.builder(
                            itemCount: profile_item.length,
                            itemBuilder: (BuildContext, index) =>
                                AppLinksWidget(
                              key: ValueKey(index),
                              index: index,
                              isactive: profile_item[index].active == "1"
                                  ? true
                                  : false,
                              profile_item: profile_item,
                              profile: "RealProfile",
                            ),
                          ),
                        ),
                  AddLinksButtons(
                      profile: "RealProfile",
                      id: id,
                      ontap: () async {
                        final RouteResponse = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NfcDashbordApp(
                                    type: "RealProfile",
                                  )),
                        );
                        if (RouteResponse == "refresh") {
                          getCardDetails();
                        }
                      }),
                ]),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
