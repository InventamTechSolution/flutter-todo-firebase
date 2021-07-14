

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel{
  String content;
  String todoId;
  Timestamp created_date;
  bool done;

  TodoModel(this.content,this.todoId,this.created_date,this.done);

  TodoModel.fromDocumetnSnapshot(DocumentSnapshot doc){
    todoId=doc.id;
    content=doc['content'];
    created_date=doc['created_date'];
    done=doc['done'];
  }
}