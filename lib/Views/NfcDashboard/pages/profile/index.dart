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
import 'package:soloconneckt/Views/ForexProfile/widgets/ApplinksWidget.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/apps/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/connections/SingleProfile.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/connections/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/qrCode/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/setting/index.dart';
import 'package:soloconneckt/Views/Profile/editProfile.dart';
import 'package:soloconneckt/Views/Profile/index.dart';
import 'package:soloconneckt/classes/pesonalProfile.dart/userprofile.dart';

import '../../../../Widgets/IconList.dart';

class NfcDashbordHome extends StatefulWidget {
  const NfcDashbordHome({Key? key}) : super(key: key);

  @override
  State<NfcDashbordHome> createState() => _NfcDashbordHomeState();
}

class _NfcDashbordHomeState extends State<NfcDashbordHome> {
  String usename = "", email = "", image = "", id = "";
  String islogin = "No";
  bool isnumber = false;
  bool isemail = false;
  bool setting = false;
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usename = prefs.getString("user_name")!;
    email = prefs.getString("user_email")!;
    image = prefs.getString("image")!;
    id = prefs.getString("user_id")!;
    String? islogin = prefs.getString("is_logged_in");
    setState(() {});
    getCardDetails();
  }

  List<PerosnalProfile_item> profile_item = [];
  bool isloading1 = true;
  getCardDetails() async {
    var url;
    if (id != "")
      url = Uri.parse(base_url + ApiUrl.getPersnalProfile(id, "false", "","PersonalProfile"));
    print(url);
    // print("idd " + id);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(response.body);
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
                  builder: (context) => NfcDashboardProfile(
                        userid: id,
                      )),
            );
          },
          icon: Icon(
            Icons.remove_red_eye,
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
        ),
        //  IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Theme.of(context).colorScheme.primaryVariant,
        //   ),
        // ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(children: [
            Container(
              padding: EdgeInsets.all( 10),
              height: MediaQuery.of(context).size.height * 0.12,
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
                                    image: NetworkImage(image != null
                                        ? imageUrlUser + image
                                        : defaultUser),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                    color: Theme.of(context).backgroundColor,
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
                                  usename,
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
                                  builder: (context) => EditProfile()),
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
                    // height: 400,
                    child:  ListView.builder(
                    // ReorderableListView.builder(
                      itemCount: profile_item.length,
                      itemBuilder: (BuildContext, index) => AppLinksWidget(
                        profile: "PersonalProfile",
                        key: ValueKey(index),
                        index: index,
                        isactive:
                            profile_item[index].active == "1" ? true : false,
                        profile_item: profile_item,
                      ),
                      // onReorder: (int oldIndex, int newIndex) {
                      //   if (newIndex > profile_item.length)
                      //     newIndex = profile_item.length;
                      //   if (oldIndex < newIndex) newIndex -= 1;

                      //   setState(() {
                      //     final  item = profile_item[oldIndex];
                      //     profile_item.removeAt(oldIndex);

                      //     print(item.title);
                      //     profile_item.insert(newIndex, item);
                      //     for(int i=0; i<profile_item.length; i++){
                      //       HttpService().UpdateCardOrder(profile_item[i].id, i.toString(), "PersonalProfile",context, ApiUrl.updateCardOrder);
                      //     }
                          
                      //   });
                      // },
                    ),
                  ),
            InkWell(
              onTap: () {
                 Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NfcDashbordApp(
                        type: "PersonalProfile",
                      )),
            );
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryVariant,
                    borderRadius: const BorderRadius.all(Radius.circular(35))),
                child: Center(
                  child: Text(
                    "+ Add another link",
                    style: ThemeHelper().TextStyleMethod2(16, context,
                        FontWeight.w500, Theme.of(context).backgroundColor),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// class AppLinksWidget extends StatefulWidget {
//   int index;
//   List<PerosnalProfile_item> profile_item;
//   bool isactive;
//   AppLinksWidget(
//       {Key? key,
//       required this.isactive,
//       required this.index,
//       required this.profile_item})
//       : super(key: key);

//   @override
//   State<AppLinksWidget> createState() => _AppLinksWidgetState();
// }

// class _AppLinksWidgetState extends State<AppLinksWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//       // height: MediaQuery.of(context).size.height * 0.15,
//       decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.primaryVariant,
//           borderRadius: const BorderRadius.all(Radius.circular(35))),
//       child: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
//               Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Image.asset(
//                   "assets/images/" +
//                       widget.profile_item[widget.index].icon.toString(),
//                   height: 45,
//                   width: 45,
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 widget.profile_item[widget.index].title,
//                 style: ThemeHelper().TextStyleMethod2(16, context,
//                     FontWeight.w500, Theme.of(context).backgroundColor),
//               ),
//             ]),
//             FlutterSwitch(
//               width: 43,
//               height: 25,
//               showOnOff: false,
//               activeColor: Palette.DarkGolden,
//               inactiveColor: Theme.of(context).backgroundColor,
//               activeToggleColor: Theme.of(context).colorScheme.primaryVariant,
//               toggleColor: Theme.of(context).colorScheme.primaryVariant,
//               value: widget.isactive,
//               onToggle: (val) {
//                 setState(() {
//                   widget.isactive = val;
//                 });
//                 String active = val ? "1" : "0";
//                 HttpService().UpdateActiveInactiveStatus(
//                     widget.profile_item[widget.index].id,
//                     active,
//                     "PersonalProfile",
//                     context,
//                     ApiUrl.updateActiveStatus);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
