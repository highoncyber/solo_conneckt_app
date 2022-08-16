import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soloconneckt/Controllers/ConnectionController.dart';
import 'package:soloconneckt/Services/ApiClient.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Services/Apis.dart';
import 'package:http/http.dart' as http;
import 'package:soloconneckt/classes/pesonalProfile.dart/userprofile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class NfcDashboardProfile extends StatefulWidget {
  var userid;
  String serial;
  NfcDashboardProfile({required this.userid, this.serial = "", Key? key})
      : super(key: key);

  @override
  State<NfcDashboardProfile> createState() => _NfcDashboardProfileState();
}

class _NfcDashboardProfileState extends State<NfcDashboardProfile> {
  List<PerosnalProfile_item> profile_item = [];
  List<UserDetails> user_item = [];
  bool isloading1 = true;
  bool isloading2 = true;

  getUserDetails() async {
    var url = Uri.parse(
        base_url + ApiUrl.getUserDetails(widget.userid, widget.serial));
    print(url);
    // print("idd " + id);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(response.body);
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        UserDetails item =
            UserDetails(d["user_name"], d["image"], d["user_id"]);
        user_item.add(item);
        // print(users[0].date);
      }

    print(user_item.length);
    isloading2 = false;
    setState(() {});
  }

  getCardDetails() async {
    var url = Uri.parse(base_url +
        ApiUrl.getPersnalProfile(
          widget.userid,
          "true",
          widget.serial,
          "PersonalProfile",
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
    isloading1 = false;
    setState(() {});
  }

  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      // Navigator.pop(context);
      // if (routeName != "") {
      //   Navigator.of(context).pushNamed(routeName);
      // }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Contact contact = Contact();
  PostalAddress address = PostalAddress(label: "Home");

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

  @override
  void initState() {
    addStringToSF();
    getUserDetails();
    getCardDetails();
    _askPermissions("");
    // TODO: implement initState
    super.initState();
  }

  ConnectionController pconnectionController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text(
          "SOLO CONNECKT\n(Personal Profile)",
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
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: isloading1 == false && isloading2 == false
              ? Column(
                  children: [
                    Expanded(
                      flex: 10,
                      child: SingleChildScrollView(
                        child: Container(
                          // color: Colors.amber,
                          child: Column(
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
                                                  user_item[0].image != null
                                                      ? imageUrlUser +
                                                          user_item[0].image
                                                      : defaultUser),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 20),
                                    height: size.height * 0.8,
                                    // width: size.width * 0.9,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                                  user_item[0].user_name,
                                                  style: ThemeHelper()
                                                      .TextStyleMethod2(
                                                          22,
                                                          context,
                                                          FontWeight.w600,
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primaryVariant),
                                                ),
                                                // // SizedBox(
                                                // //   height: 15,
                                                // // ),
                                                // // Text(
                                                // //   "@ " +
                                                // //       user_item[0].profession +
                                                // //       " " +
                                                // //       user_item[0].worksAt,
                                                // //   style: ThemeHelper()
                                                // //       .TextStyleMethod2(
                                                // //           16,
                                                // //           context,
                                                // //           FontWeight.w500,
                                                // //           Theme.of(context)
                                                // //               .colorScheme
                                                // //               .primaryVariant),
                                                // // ),
                                                // SizedBox(
                                                //   height: 10,
                                                // ),
                                                // Text(
                                                //   user_item[0].profile_slogan,
                                                //   style: ThemeHelper()
                                                //       .TextStyleMethod2(
                                                //           16,
                                                //           context,
                                                //           FontWeight.w500,
                                                //           Theme.of(context)
                                                //               .colorScheme
                                                //               .primaryVariant),
                                                // ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        // ApiCall().MoveToConnection(
                                                        //     widget.exchangeid,
                                                        //     context);
                                                        // pconnectionController
                                                        //     .getExchangeUser(id);
                                                        // pconnectionController
                                                        //     .getConnectionUser(id);
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 130,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30)),
                                                                gradient:
                                                                    LinearGradient(
                                                                  begin: Alignment
                                                                      .topRight,
                                                                  end: Alignment
                                                                      .bottomLeft,
                                                                  colors: [
                                                                    Colors
                                                                        .black,
                                                                    Colors.grey,
                                                                  ],
                                                                )),
                                                        child: Center(
                                                          child: Text(
                                                            "SAVE CONTACT",
                                                            style: ThemeHelper()
                                                                .TextStyleMethod2(
                                                                    12,
                                                                    context,
                                                                    FontWeight
                                                                        .w500,
                                                                    Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        print(
                                                              "profile idd ${profile_item[
                                                                          0]
                                                                      .id}");
                                                        if (widget.serial !=
                                                            "") {
                                                          
                                                          await HttpService()
                                                              .addToExchangeAndConnection(
                                                                  id,
                                                                  user_item[
                                                                          0]
                                                                      .user_id,
                                                                  context,
                                                                  ApiUrl
                                                                      .addToExchange);
                                                          pconnectionController
                                                              .getExchangeUser(
                                                                  id);
                                                          pconnectionController
                                                              .getConnectionUser(
                                                                  id);
                                                        } else {
                                                          
                                                          await HttpService()
                                                              .addToExchangeAndConnection(
                                                                  id,
                                                                  widget.userid,
                                                                  context,
                                                                  ApiUrl
                                                                      .addToExchange);
                                                          pconnectionController
                                                              .getExchangeUser(
                                                                  id);
                                                          pconnectionController
                                                              .getConnectionUser(
                                                                  id);
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 130,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30)),
                                                                gradient:
                                                                    LinearGradient(
                                                                  begin: Alignment
                                                                      .topRight,
                                                                  end: Alignment
                                                                      .bottomLeft,
                                                                  colors: [
                                                                    Colors
                                                                        .black,
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
                                                                    FontWeight
                                                                        .w500,
                                                                    Colors
                                                                        .white),
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

                              SizedBox(
                                height: 20,
                              ),
                              profile_item.length != 0
                                  ? GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 2.0,
                                        mainAxisSpacing: 2.0,
                                      ),
                                      itemCount: profile_item.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            redirectlink(
                                                profile_item[index].title,
                                                profile_item[index].url);
                                          },
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: size.width * 0.15,
                                                  height: size.height * 0.08,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/" +
                                                                  profile_item[
                                                                          index]
                                                                      .icon
                                                                      .toString()),
                                                          fit: BoxFit.cover),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))
                                                      // shape: BoxShape.circle,
                                                      ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    profile_item[index].title,
                                                    textAlign: TextAlign.center,
                                                    style: ThemeHelper()
                                                        .TextStyleMethod1(
                                                            12,
                                                            context,
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

redirectlink(title, ProfileUrl) async {
  print(title);
  if (title == "Instagram") {
    var url = 'https://www.instagram.com/${ProfileUrl}/';

    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  } else if (title == "Call") {
    var url = 'tel:${ProfileUrl}';
    //  const url = "tel:1234567";

    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launch(
        url,
        enableJavaScript: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  } else if (title == "mail") {
    var url = 'mailto:${ProfileUrl}';
    //  const url = "tel:1234567";

    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launch(
        url,
        enableJavaScript: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  } else {
    //  var url = 'mailto:${ProfileUrl}';
    //  const url = "tel:1234567";

    // ignore: deprecated_member_use
    if (await canLaunch(ProfileUrl)) {
      await launch(
        ProfileUrl,
        enableJavaScript: true,
      );
    } else {
      throw 'There was a problem to open the url: $ProfileUrl';
    }
  }
}
