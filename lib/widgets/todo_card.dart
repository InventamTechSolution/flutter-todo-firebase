import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';

class TodoCard extends StatelessWidget {
  final String uid;
  final TodoModel todo;

  const TodoCard({Key key, this.uid, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.title.toString(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                      todo.content,
                      style: (todo.done==false)?TextStyle(
                      fontSize: 15,
                    ):TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ),
                Checkbox(
                  value: todo.done,
                  onChanged: (newValue) {
                    Database().updateTodo(newValue, uid, todo.todoId);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}