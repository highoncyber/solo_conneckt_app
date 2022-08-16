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
import 'package:soloconneckt/Views/NfcDashboard/pages/apps/index.dart';
import 'package:soloconneckt/classes/pesonalProfile.dart/userprofile.dart';


class Sorting extends StatefulWidget {
  String profile;
   Sorting({Key? key,required this.profile}) : super(key: key);

  @override
  State<Sorting> createState() => _SortingState();
}

class _SortingState extends State<Sorting> {
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
      url = Uri.parse(base_url +
          ApiUrl.getPersnalProfile(id, "false", "", widget.profile));
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
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.primaryVariant,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            isloading1 == true
                ? CircularProgressIndicator()
                : Expanded(
                    // height: 400,
                    child:
                        // ListView.builder(
                        ReorderableListView.builder(
                      itemCount: profile_item.length,
                      itemBuilder: (BuildContext, index) => SocialMediaLinksWidget(
                        key: ValueKey(index),
                        icon: profile_item[index].icon,
                        label: profile_item[index].title,
                        title: profile_item[index].title,
                        isSort: true,
                        type: "",
                        // index: index,
                        // isactive:
                        //     profile_item[index].active == "1" ? true : false,
                        // profile_item: profile_item,
                      ),
                      onReorder: (int oldIndex, int newIndex) {
                        if (newIndex > profile_item.length)
                          newIndex = profile_item.length;
                        if (oldIndex < newIndex) newIndex -= 1;

                        setState(() {
                          final item = profile_item[oldIndex];
                          profile_item.removeAt(oldIndex);

                          print(item.title);
                          profile_item.insert(newIndex, item);
                          for (int i = 0; i < profile_item.length; i++) {
                            HttpService().UpdateCardOrder(
                                profile_item[i].id,
                                i.toString(),
                                widget.profile,
                                context,
                                ApiUrl.updateCardOrder);
                          }
                        });
                      },
                    ),
                  ),
          ]),
        ),
      ),
    );
  }
}
