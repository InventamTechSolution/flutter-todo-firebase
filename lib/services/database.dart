


import 'package:cloud_firestore/cloud_firestore.dart';
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

}