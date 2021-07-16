

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/authController.dart';
import 'package:todo_app/controllers/todoController.dart';
import 'package:todo_app/controllers/userController.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/todo_card.dart';

class Home extends GetWidget<AuthController> {
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          initState: (_) async {
            Get.find<UserController>().user = await Database().getUser(Get.find<AuthController>().user.uid);
          },
          builder: (_) {
            if (_.user.name != null) {
              return Text("Welcome " + _.user.name);
            } else {
              return Text("loading...");
            }
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              controller.SignOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Add Todo Here:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Card(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Title",
                        ),
                        controller: _titleController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Todo Here",
                        ),
                        maxLines: 5,
                        controller: _todoController,
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.add),
                      //   onPressed: () {
                      //     if (_todoController.text != "") {
                      //       Database().addTodo(_titleController.text,_todoController.text, controller.user.uid);
                      //       _todoController.clear();
                      //     }
                      //   },
                      // ),
                      FlatButton(
                          onPressed: (){
                          if (_todoController.text != "") {
                                Database().addTodo(_titleController.text,_todoController.text, controller.user.uid);
                                _todoController.clear();
                                _titleController.clear();
                              }
                          },
                          color: Colors.blue,
                          child: Text("Add",
                          style: TextStyle(color: Colors.white,fontSize: 17),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "Your Todos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            GetX<TodoController>(
              init: Get.put<TodoController>(TodoController()),
              builder: (TodoController todoController) {
                print('todoController: $todoController');
                print('todoController.todos: ${todoController.todos}');
                if (todoController != null && todoController.todos != null && todoController.todos.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: todoController.todos.length,
                      itemBuilder: (_, index) {
                        return TodoCard(
                            uid: controller.user.uid,
                            todo:todoController.todos[index],
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
        //     GetX<UserController>(
        //         builder: (_){
        //           return Text(_.user.email);
        //         }
        // ),
          ],
        ),
      ),
    );
  }
}