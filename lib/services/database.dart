


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/models/user.dart';

class Database{
  final FirebaseFirestore  _firebasefirestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user)async{
    try{
      await _firebasefirestore.collection("users").doc(user.id).set({
        "name":user.name,
        "email":user.email,
      });
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid)async{
    try{
      DocumentSnapshot doc = await _firebasefirestore.collection("users").doc(uid).get();
      return UserModel.fromDocumetnSnapshot(doc);
    }catch(e){
      print(e);
      rethrow;
    }
  }


  Future<void> addTodo(String content, String uid) async {
    try {
      await _firebasefirestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .add({
              'user_id':uid,
              'created_date': Timestamp.now(),
              'content': content,
              'done': false,
        });
      } catch (e) {
        print(e);
        rethrow;
      }
  }

  Stream<List<TodoModel>> todoStream(String uid) {
    return _firebasefirestore
        .collection("users")
        .doc(uid)
        .collection("todos")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(TodoModel.fromDocumetnSnapshot(element));
      });
      return retVal;
    });
  }


}