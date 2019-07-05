import 'package:floor_start/database/task_dao.dart';
import 'package:floor_start/model/task.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

displayDialog(
    {@required BuildContext context,
    @required TaskDao dao,
    bool update,
    Task task}) async {
  final TextEditingController textEditingController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            update ? 'Update task' : 'Add a task'
          ),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
                hintText: update ? task.title : "enter a title"),
                
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(update ? 'UPDATE' : 'OK'),
              onPressed: () async {
                final message = textEditingController.text;
                if (update) {
                  task.title = message;
                  await dao.updateTask(task);
                } else {
                  final task = Task(
                      null, message, DateTime.now().millisecondsSinceEpoch);
                  await dao.insertTask(task);
                }
                textEditingController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
