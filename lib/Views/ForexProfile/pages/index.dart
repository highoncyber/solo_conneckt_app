import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/ForexProfile/pages/RegisterForex.dart';
import 'package:soloconneckt/Views/ForexProfile/pages/profile.dart';
import 'package:soloconneckt/Views/ForexProfile/widgets/ApplinksWidget.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/apps/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/connections/index.dart';
import 'package:soloconneckt/classes/pesonalProfile.dart/userprofile.dart';

import '../../../../Widgets/IconList.dart';
import '../widgets/ApplinksButton.dart';
import 'Porfolio.dart';

class ForexProfileHome extends StatefulWidget {
  const ForexProfileHome({Key? key}) : super(key: key);

  @override
  State<ForexProfileHome> createState() => _ForexProfileHomeState();
}

class _ForexProfileHomeState extends State<ForexProfileHome> {
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
            "ForexProfile",
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
                  builder: (context) => ForexProfileWidget(
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
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                              profile: "ForexProfile",
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
                          height: 20,
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
                          // height: 400,
                          child: ListView.builder(
                            // ReorderableListView.builder(
                            itemCount: profile_item.length,
                            itemBuilder: (BuildContext, index) =>
                                AppLinksWidget(
                              key: ValueKey(index),
                              index: index,
                              isactive: profile_item[index].active == "1"
                                  ? true
                                  : false,
                              profile_item: profile_item,
                              profile: "ForexProfile",
                            ),
                            // onReorder: (int oldIndex, int newIndex) {
                            //   if (newIndex > profile_item.length)
                            //     newIndex = profile_item.length;
                            //   if (oldIndex < newIndex) newIndex -= 1;

                            //   setState(() {
                            //     final item = profile_item[oldIndex];
                            //     profile_item.removeAt(oldIndex);

                            //     print(item.title);
                            //     profile_item.insert(newIndex, item);
                            //     for (int i = 0; i < profile_item.length; i++) {
                            //       HttpService().UpdateCardOrder(
                            //           profile_item[i].id,
                            //           i.toString(),
                            //           "ForexProfile",
                            //           context,
                            //           ApiUrl.updateCardOrder);
                            //     }
                            //   });
                            // },
                          ),
                        ),
                  AddLinksButtons(
                      profile: "ForexProfile",
                      id: id,
                      ontap: () async {
                        final RouteResponse = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NfcDashbordApp(
                                    type: "ForexProfile",
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

class ConnectionScreen extends StatelessWidget {
  ConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NfcDashbordConnections(),
    );
  }
}
