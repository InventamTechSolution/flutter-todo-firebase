

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/authController.dart';

class Home extends GetWidget<AuthController> {
  final TextEditingController _todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: GetX<UserController>(
        //   initState: (_) async {
        //     Get.find<UserController>().user =
        //     await Database().getUser(Get.find<AuthController>().user.uid);
        //   },
        //   builder: (_) {
        //     if (_.user.name != null) {
        //       return Text("Welcome " + _.user.name);
        //     } else {
        //       return Text("loading...");
        //     }
        //   },
        // ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.SignOut();
            },
          ),
        ],
      ),
    );
  }
}