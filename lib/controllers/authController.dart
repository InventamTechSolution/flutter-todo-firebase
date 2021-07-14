

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/userController.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/utils/root.dart';

class AuthController extends GetxController
{
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = Rx<User>();

  // String get user=> _firebaseUser.value?.email;
  User get user => _firebaseUser.value;


  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser(String name,String email,String password) async{
    try{
      UserCredential _userCredential =  await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      // Get.offAll(Root());
      UserModel _user = UserModel(
          id: _userCredential.user.uid,
          name: name,
          email: email,
      );
      if(await Database().createNewUser(_user)){
        Get.find<UserController>().user = _user;
        Get.back();
      }
    }catch(e){
      Get.snackbar("Error creating account", e.message,snackPosition: SnackPosition.BOTTOM);
    }
  }

  void login(String email,String password) async{
    try{
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      Get.put<UserController>(UserController()).user = await Database().getUser(_userCredential.user.uid);
      Get.offAll(Root());
    }catch(e){
      Get.snackbar("Error in login", e.message,snackPosition: SnackPosition.BOTTOM);
    }
  }

  void SignOut()async{
    try{
      await _auth.signOut();
      Get.find<UserController>().clear();
    }catch(e){
      Get.snackbar("Error in signing out", e.message,snackPosition: SnackPosition.BOTTOM);
    }
  }

}