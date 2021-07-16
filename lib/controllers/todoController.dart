
import 'package:get/get.dart';
import 'package:todo_app/controllers/authController.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';

class TodoController extends GetxController {
  @override
  void onInit() {
    Future.delayed(Duration(milliseconds: 100), () {
      print('oninit todo');
      String uid = Get.find<AuthController>().user.uid;
      todoList.bindStream(Database().todoStream(uid)); //stream coming from firebase
      print('todoList: $todoList');
    });
  }

  Rxn<List<TodoModel>> todoList = Rxn<List<TodoModel>>();


  List<TodoModel> get todos => todoList.value;
}