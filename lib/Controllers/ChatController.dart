import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../Services/Apis.dart';
import '../Services/constants.dart';
import '../classes/ChatGroup.dart';

class ChatController extends GetxController {
  // RxList chatlist<Chat_item>=[].obs ;
  late var chatlist = <Chat_item>[];
  RxBool isloading = true.obs;

  //   Future<List<Chat_item>> getChat(id) async {
  //   var url = Uri.parse(base_url + ApiUrl.getChat(id));
  //   print(url);
  //   var response = await http.get(url);
  //   var JsonData = json.decode(response.body);
  //   List<Chat_item> chat = [];
  //   if (JsonData[0]["code"] != 0)
  //     // ignore: curly_braces_in_flow_control_structures
  //     for (var d in JsonData) {
  //       Chat_item item = Chat_item(
  //         d["id"],
  //         d["image"],
  //         d["ispublic"],
  //         d["name"],
  //         d["user_id"],
  //         d["isLiked"],
  //       );
  //       // ignore: invalid_use_of_protected_member
  //       chat.add(item);
  //       // print(users[0].date);
  //     }
  //   return chat;
  // }

 getChat(id) async {
    var url = Uri.parse(base_url + ApiUrl.getChat(id));
    print(url);
    var response = await http.get(url);
    var JsonData = json.decode(response.body);
    // List<Chat_item> chat = [];
    if (JsonData[0]["code"] != 0)
      // ignore: curly_braces_in_flow_control_structures
       chatlist.clear();
      for (var d in JsonData) {
        Chat_item item = Chat_item(
          d["id"],
          d["image"],
          d["ispublic"],
          d["name"],
          d["user_id"],
          d["isLiked"],
        );
        // ignore: invalid_use_of_protected_member
        chatlist.add(item);
        print(chatlist[0].name);
      }
      isloading.value=false;
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
