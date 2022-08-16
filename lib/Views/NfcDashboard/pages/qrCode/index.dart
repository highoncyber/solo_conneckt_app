import 'package:flutter/material.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:soloconneckt/Widgets/textFeildDecoration.dart';

import '../../../../Widgets/IconList.dart';
import '../setting/NFCScan.dart';
import '../setting/QRScan/index.dart';

class NfcDashbordShare extends StatefulWidget {
  const NfcDashbordShare({Key? key}) : super(key: key);

  @override
  State<NfcDashbordShare> createState() => _NfcDashbordShareState();
}

class _NfcDashbordShareState extends State<NfcDashbordShare> {
  bool fav = false;

  String id = "";

  // addStringToSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   id = prefs.getString("user_id")!;
  //   // String? islogin2 = prefs.getString("is_logged_in");
  //   setState(() {});
  //   // getChat();
  //   // getDirectChat();
  //   _chatController.getChat(id);
  // }

  // Future<List<DirectChat_item>> getDirectChat() async {
  //   var url = Uri.parse(base_url + ApiUrl.getDirectChat(id));
  //   print(url);
  //   var response = await http.get(url);
  //   var JsonData = json.decode(response.body);
  //   print(JsonData[0]["code"]);

  //   List<DirectChat_item> Directchat = [];
  //   if (JsonData[0]["code"] != 0)
  //     // ignore: curly_braces_in_flow_control_structures
  //     for (var d in JsonData) {
  //       DirectChat_item item = DirectChat_item(
  //           d["id"],
  //           d["image"],
  //           d["message_content"],
  //           d["user_name"],
  //           d["user_id"],
  //           d["is_blocked"]);
  //       // ignore: invalid_use_of_protected_member
  //       Directchat.add(item);
  //       // print(users[0].date);
  //     }

  //   print(" blockedd ${Directchat[0].is_blocked}");
  //   ;

  //   return Directchat;
  // }

  // @override
  // void initState() {
  //   addStringToSF();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text(
          "SOLO CONNECKT",
          style: ThemeHelper()
              .TextStyleMethod2(20, context, FontWeight.w600, Theme.of(context).colorScheme.primaryVariant),
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
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Scan with NFC Or Scan With QR",
                  textAlign: TextAlign.center,
                  style: ThemeHelper().TextStyleMethod2(
                      20, context, FontWeight.w500, Theme.of(context).colorScheme.primaryVariant),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>NFCScan(
                                  )),
                        );
                },
                child: Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryVariant,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Center(
                    child: Text(
                      "Scan With NFC",
                      style: ThemeHelper().TextStyleMethod2(16, context,
                          FontWeight.bold, Theme.of(context).backgroundColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () {
                   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductActivation(
                                  )),
                        );
                },
                child: Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryVariant,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Center(
                    child: Text(
                      "Scan with QR",
                      style: ThemeHelper().TextStyleMethod2(16, context,
                          FontWeight.bold, Theme.of(context).backgroundColor),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
