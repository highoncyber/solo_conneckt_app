import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:perspective_pageview/perspective_pageview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Controllers/ConnectionController.dart';
import 'package:soloconneckt/Controllers/NewsFeedController.dart';
import 'package:soloconneckt/Services/ApiCalling.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Views/ForexProfile/pages/RegisterForex.dart';
import 'package:soloconneckt/Views/ForexProfile/widgets/ProfileIconWidget.dart';
import 'package:soloconneckt/classes/post.dart';

import '../../../classes/pesonalProfile.dart/userprofile.dart';
import '../../Chat/DirectChatScreen.dart';
import '../widgets/profilePortfolioWIdget.dart';
import 'Porfolio.dart';

class ForexProfileWidget extends StatefulWidget {
  String id, exchangeid;
  ForexProfileWidget({Key? key, required this.id, this.exchangeid = ""})
      : super(key: key);

  @override
  State<ForexProfileWidget> createState() => _ForexProfileWidgetState();
}

class _ForexProfileWidgetState extends State<ForexProfileWidget> {
  List<Portfolio_item> portfolio = [];
  List<PerosnalProfile_item> profile_item = [];
  bool isloading = true;
  bool isloading2 = true;
  int length = 0;

  String id = "";

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("is_logged_in"));
    // usename = prefs.getString("user_name")!;
    // email = prefs.getString("user_email")!;
    // // image = prefs.getString("image")!;
    // // id = int.parse(prefs.getString("id")!);
    id = prefs.getString("user_id") == null ? "" : prefs.getString("user_id")!;
    setState(() {});
  }

  bool hasProfile = false;
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
    } else {
      hasProfile = true;
    }
    print(user_item.length);
    setState(() {});
  }

  getCardDetails() async {
    var url = Uri.parse(base_url +
        ApiUrl.getPersnalProfile(
          widget.id,
          "true",
          "",
          "ForexProfile",
        ));
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
    isloading2 = false;
    // isloading1 = false;
    setState(() {});
  }

  getPortfolio() async {
    var url =
        Uri.parse(base_url + ApiUrl.getPortfolio(widget.id, "ForexProfile"));
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        Portfolio_item item = Portfolio_item(
            d["portfolio_id"], d["profile_type"], d["user_id"], d["file"]);
        // ignore: invalid_use_of_protected_member
        portfolio.add(item);
        // print(users[0].date);
      }
    if (portfolio.length < 10) {
      length = portfolio.length;
    } else {
      length = 10;
    }
    print(portfolio.length);
    isloading = false;
    setState(() {});
  }

  var currentIndex = 3;

  @override
  void initState() {
    getPortfolio();
    getCardDetails();
    getUserDetails();
    addStringToSF();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NewsFeedController _newsFeedController = Get.find();
    Size size = MediaQuery.of(context).size;
    final ThemeData mode = Theme.of(context);
    //  gettheme();
    var whichMode = mode.brightness;
    if (whichMode == Brightness.light) {
      _newsFeedController.theme.value = "Light";
      _newsFeedController.isSwitched.value = true;
    } else {
      _newsFeedController.theme.value = "Dark";
      _newsFeedController.isSwitched.value = false;
    }

    sendConnection() async {
      try {
        var url = Uri.parse(base_url + ApiUrl.insertConnection);
        // print("done");
        var response;
        response = await http.post(url, body: {
          // "message_content": msgcontrl.text,
          "receiver_id": widget.id,
          "sender_id": id,
          "profile_type": "ForexProfile",
          "auth_key": auth_key,
        });

        var data = json.decode(response.body);
        var code = data[0]['code'];

        if (code == 0) {
          // await dialog.hide();
          // ShowResponse(data,context);
        } else if (code == 1) {
          setState(() {});
        } else {
          // await dialog.hide();
          // ShowResponse("Some Error Occured. Contact Support");
        }
      } catch (e) {
        print("error " + e.toString());
      }
    }

    ConnectionController pconnectionController = Get.find();
    print("exchange id ${widget.exchangeid} ");
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text(
          "SOLO CONNECKT\n(Forex Profile)",
          style: ThemeHelper().TextStyleMethod2(16, context, FontWeight.w600,
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
      body: !isloading2 && !isloading
          ? JsonData[0]["code"] == 0
              ? Container(
                  child: Center(
                    child: Text(
                      "The Forex Account has not been created",
                      style: ThemeHelper().TextStyleMethod2(
                          16,
                          context,
                          FontWeight.w500,
                          Theme.of(context).colorScheme.primaryVariant),
                    ),
                  ),
                )
              : Container(
                  width: size.width * 1,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: Container(
                                height: size.height * 0.72,
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            user_item[0].profile_image != null
                                                ? imageUrlUser +
                                                    user_item[0].profile_image
                                                : defaultUser),
                                        fit: BoxFit.cover),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              height: size.height * 0.8,
                              // width: size.width * 0.9,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // IconButton(
                                          //   onPressed: () {},
                                          //   icon: Icon(
                                          //     Icons.android,
                                          //     size: 40,
                                          //   ),
                                          //   color: Theme.of(context)
                                          //       .colorScheme
                                          //       .primaryVariant,
                                          // ),
                                          // IconButton(
                                          //   onPressed: () {},
                                          //   icon: Icon(Icons.shopping_bag,
                                          //       size: 40),
                                          //   color: Theme.of(context)
                                          //       .colorScheme
                                          //       .primaryVariant,
                                          // ),
                                          // IconButton(
                                          //   onPressed: () {},
                                          //   icon: Icon(Icons.apple, size: 40),
                                          //   color: Theme.of(context)
                                          //       .colorScheme
                                          //       .primaryVariant,
                                          // ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            user_item[0].profile_name,
                                            style: ThemeHelper()
                                                .TextStyleMethod2(
                                                    22,
                                                    context,
                                                    FontWeight.w600,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primaryVariant),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "@ " +
                                                user_item[0].profession +
                                                " " +
                                                user_item[0].worksAt,
                                            style: ThemeHelper()
                                                .TextStyleMethod2(
                                                    16,
                                                    context,
                                                    FontWeight.w500,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primaryVariant),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            user_item[0].profile_slogan,
                                            style: ThemeHelper()
                                                .TextStyleMethod2(
                                                    16,
                                                    context,
                                                    FontWeight.w500,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primaryVariant),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await HttpService()
                                                      .addToExchangeAndConnection(
                                                          id,
                                                          widget.id,
                                                          context,
                                                          ApiUrl.addToExchange);
                                                  pconnectionController
                                                      .getExchangeUser(id);
                                                  pconnectionController
                                                      .getConnectionUser(id);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topRight,
                                                        end: Alignment
                                                            .bottomLeft,
                                                        colors: [
                                                          Colors.black,
                                                          Colors.grey,
                                                        ],
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      "CONNECKT",
                                                      style: ThemeHelper()
                                                          .TextStyleMethod2(
                                                              12,
                                                              context,
                                                              FontWeight.w500,
                                                              Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                    print(
                                                              "forex profile idd ${widget.id} && ${id}");
                                                  await HttpService()
                                                      .addToExchangeAndConnection(
                                                          id,
                                                          widget.id,
                                                          context,
                                                          ApiUrl.addToExchange);
                                                  pconnectionController
                                                      .getExchangeUser(id);
                                                  pconnectionController
                                                      .getConnectionUser(id);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topRight,
                                                        end: Alignment
                                                            .bottomLeft,
                                                        colors: [
                                                          Colors.black,
                                                          Colors.grey,
                                                        ],
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      "SWAP",
                                                      style: ThemeHelper()
                                                          .TextStyleMethod2(
                                                              12,
                                                              context,
                                                              FontWeight.w500,
                                                              Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ]),
                                  ]),
                            ),
                            // Positioned(
                            //   top: 10,
                            //   right: 30,
                            //   child: Obx(
                            //     () => FlutterSwitch(
                            //       inactiveIcon: Icon(Icons.dark_mode),
                            //       activeIcon: Icon(Icons.light_mode_rounded),
                            //       width: 48,
                            //       height: 25,
                            //       showOnOff: false,
                            //       activeColor: Colors.black,
                            //       inactiveColor: Colors.white,
                            //       activeToggleColor: Colors.white,
                            //       // toggleColor: Colors.black,
                            //       value: _newsFeedController.isSwitched.value,
                            //       onToggle: (val) {
                            //         if (Get.isDarkMode) {
                            //           _newsFeedController.theme.value = "Light";
                            //           Get.changeThemeMode(ThemeMode.light);
                            //         } else {
                            //           _newsFeedController.theme.value = "Dark";
                            //           Get.changeThemeMode(ThemeMode.dark);
                            //         }
                            //         _newsFeedController.isSwitched.value = val;
                            //         // setState(() {
                            //         //   isSwitched = val;
                            //         // });
                            //       },
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Container(
                            width: 800,
                            height: 100,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: profile_item.length,
                                itemBuilder: (BuildContext, index) =>
                                    IconWidget(
                                      image: profile_item[index].icon,
                                      link: profile_item[index].url,
                                      title: profile_item[index].title,
                                    ))),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Portfolio ",
                                style: ThemeHelper().TextStyleMethod2(
                                    18,
                                    context,
                                    FontWeight.w600,
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryVariant),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Portfolio(
                                              isView: true,
                                              profile: "ForexProfile",
                                              user_id: widget.id,
                                            )),
                                  );
                                },
                                child: Text(
                                  "View All",
                                  style: ThemeHelper().TextStyleMethod2(
                                      14,
                                      context,
                                      FontWeight.w500,
                                      Theme.of(context)
                                          .colorScheme
                                          .primaryVariant),
                                ),
                              ),
                            ],
                          ),
                        ),
                        !isloading
                            ? portfolio.length < 1
                                ? Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Your portfolio has no image.",
                                      style: ThemeHelper().TextStyleMethod2(
                                          14,
                                          context,
                                          FontWeight.w500,
                                          Theme.of(context)
                                              .colorScheme
                                              .primaryVariant),
                                    ),
                                  )
                                : PortfolioWidget(
                                    length: length, portfolio: portfolio)
                            : CircularProgressIndicator(),
                      ],
                    ),
                  ),
                )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
