


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


  Future<void> addTodo(String title,String content, String uid) async {
    try {
      await _firebasefirestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .add({
              'user_id':uid,
              'created_date': Timestamp.now(),
              'title':title,
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
        .orderBy("created_date", descending: true) // dateCreated is an issue
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> retVal = [];
      // print('query: $query');
      // print('uid: $uid');
      // print('query.docs: ${query.docs}');
      query.docs.forEach((element) {
        // print('TodoModel.fromDocumentSnapshot(element): ${TodoModel.fromDocumentSnapshot(element)}');
        retVal.add(TodoModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> updateTodo(bool newValue, String uid, String todoId) async {
    try {
      _firebasefirestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }


}