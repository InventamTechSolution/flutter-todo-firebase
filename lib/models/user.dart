

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserModel{
  String id;
  String name;
  String email;

  UserModel({this.id,this.name,this.email});

  UserModel.fromDocumetnSnapshot(DocumentSnapshot doc){
    id=doc.id;
    name=doc["name"];
    email=doc["email"];
  }

}