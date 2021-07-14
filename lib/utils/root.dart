

import 'dart:developer';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/authController.dart';
import 'package:todo_app/controllers/userController.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/login.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {

    return Obx((){
      return (Get.find<AuthController>().user != null) ? Home() : Login();
    });

    // return GetX(
    //   initState: (_) async {
    //     Get.put<UserController>(UserController());
    //   },
    //   builder: (_) {
    //     if (Get.find<AuthController>().user?.uid != null){
    //       return Home();
    //     } else {
    //       return Login();
    //     }
    //   },
    // );
  }
}