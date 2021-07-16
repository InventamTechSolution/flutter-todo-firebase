

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TodoModel{

  String content;
  String todoId;
  String title;
  Timestamp created_date;
  bool done;

  TodoModel(
      this.content,
      this.title,
      this.todoId,
      this.created_date,
      this.done
      );


  TodoModel.fromDocumentSnapshot(DocumentSnapshot documentsnapshot){

    todoId=documentsnapshot.id;
    title=documentsnapshot["title"];
    content = documentsnapshot["content"];
    created_date=documentsnapshot["created_date"];
    done=documentsnapshot["done"];
  }


}