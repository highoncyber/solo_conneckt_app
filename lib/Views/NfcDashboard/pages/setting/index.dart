import 'package:flutter/material.dart';
import 'package:soloconneckt/Services/constants.dart';
import 'package:soloconneckt/Styles/ThemeHelper.dart';
import 'package:soloconneckt/Styles/palette.dart';
import 'package:soloconneckt/Views/NewsFeed/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/pages/referalPage/index.dart';
import 'package:soloconneckt/Views/NfcDashboard/widgets/settingsWidget.dart';

import '../../../../Widgets/IconList.dart';
import '../../../Nfc.dart';

class NfcDashbordSetting extends StatefulWidget {
  const NfcDashbordSetting({Key? key}) : super(key: key);

  @override
  State<NfcDashbordSetting> createState() => _NfcDashbordSettingState();
}

class _NfcDashbordSettingState extends State<NfcDashbordSetting> {
  bool fav = false;
  int tag = 0;

  int tabindex = 0;


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
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    "Settings",
                    textAlign: TextAlign.center,
                    style: ThemeHelper().TextStyleMethod2(
                        20,
                        context,
                        FontWeight.w500,
                        Theme.of(context).colorScheme.primaryVariant),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SettingListWidget(
                text: "Activate you product",
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyAppNFc()),
                  );
                },
              ),
              SettingListWidget(
                text: "how to use Solo Conneckt",
                ontap: () {},
              ),
              SettingListWidget(
                text: "My Products",
                ontap: () {},
              ),
              SettingListWidget(
                text: "Earnings",
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NfcDashboard()),
                  );
                },
              ),
              SettingListWidget(
                text: "Logout",
                isIconVisible: false,
                ontap: () {},
              )
            ]),
          ),
        ),
      ),
    );
  }
}
