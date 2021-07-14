


import 'package:get/get.dart';
import 'package:todo_app/models/user.dart';

class UserController extends  GetxController{
  Rx<UserModel> _usermodel = UserModel().obs;

  UserModel get user => _usermodel.value;

  set user(UserModel value) => this._usermodel.value=value;

  void clear(){
    _usermodel.value = UserModel();
  }
}