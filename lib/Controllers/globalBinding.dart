

import 'package:get/get.dart';

import 'ChatController.dart';
import 'ConnectionController.dart';
import 'NewsFeedController.dart';
import 'userController.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NewsFeedController());
    Get.put(ChatController());
    Get.put(UserController());
    Get.put(ConnectionController());
  }
}
