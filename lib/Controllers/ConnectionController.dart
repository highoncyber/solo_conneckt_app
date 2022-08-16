import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:soloconneckt/classes/pesonalProfile.dart/userprofile.dart';
import 'package:soloconneckt/classes/post.dart';

import '../Services/Apis.dart';
import '../Services/constants.dart';
import '../classes/ChatGroup.dart';

class ConnectionController extends GetxController {
  // RxList Connectionuser_item<ExchangeUser>=[].obs ;
  late var Exchangeist = <ExchangeUser>[].obs;
  late var Connectionuser_item = <ExchangeUser>[].obs;
  RxBool isloading = true.obs;
  RxBool isloading2 = true.obs;
  var tabindex=0.obs;
  late var portfolio = <Portfolio_item>[].obs;
  RxBool isloading3 = true.obs;


  getConnectionUser(id) async {
    isloading.value = true;
    var url = Uri.parse(base_url + ApiUrl.getConnectionUser(id));
    print(url);
    // print("idd " + id);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(response.body);
     Connectionuser_item.clear();
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        ExchangeUser item =
             ExchangeUser(d["user_name"], d["image"], d["exchange_id"],d["id"],d["user_id"]);
        Connectionuser_item.add(item);
        // print(users[0].date);
      }

    print(Connectionuser_item.length);
     isloading.value = false;
  }


getExchangeUser(id) async {
   isloading2.value = true;
    var url = Uri.parse(base_url + ApiUrl.getExchangeUser(id));
    print(url);
    // print("idd " + id);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(response.body);
     Exchangeist.clear();
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        ExchangeUser item =
            ExchangeUser(d["user_name"], d["image"], d["exchange_id"],d["id"],d["user_id"]);
        Exchangeist.add(item);
        // print(users[0].date);
      }

    print(Exchangeist.length);
    isloading2.value = false;
    // setState(() {});
  }

  

  getPortfolio(user_id,profile) async {
    var url = Uri.parse(
        base_url + ApiUrl.getPortfolio(user_id, profile));
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    print(JsonData[0]["code"]);
     portfolio.clear();
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
      for (var d in JsonData) {
        Portfolio_item item = Portfolio_item(
            d["portfolio_id"], d["profile_type"], d["user_id"], d["file"]);
        // ignore: invalid_use_of_protected_member
        portfolio.add(item);
        // print(users[0].date);
      }

    print(portfolio.length);
    isloading3.value = false;
  }



  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    // gettheme();
    super.onInit();
  }

  // gettheme() {
  //   var brightness = SchedulerBinding.instance!.window.platformBrightness;
  //   bool isDarkMode = brightness == Brightness.dark;
  //   if (isDarkMode) {
  //     theme.value = "Dark";
  //     isSwitched.value=true;
  //   } else {
  //     theme.value = "Light";
  //      isSwitched.value=false;
  //   }
  // }
 

  
}
