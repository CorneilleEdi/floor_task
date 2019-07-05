import 'package:floor_start/database/task_dao.dart';
import 'package:floor_start/model/task.dart';
import 'package:floor_start/screen/text_input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListPage extends StatelessWidget {
  final String title;
  final TaskDao dao;

  ListPage({
    Key key,
    @required this.title,
    @required this.dao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
       
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () =>
            displayDialog(context: context, dao: dao, update: false),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream: dao.findAllTasksAsStream(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return Container();

                final tasks = snapshot.data;

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (_, index) {
                    return ListCell(
                      task: tasks[index],
                      dao: dao,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

_formatDate(int at) {
  return DateFormat.yMd()
      .add_jm()
      .format(DateTime.fromMillisecondsSinceEpoch(at));
}


class ListCell extends StatelessWidget {
  const ListCell({
    Key key,
    @required this.task,
    @required this.dao,
  }) : super(key: key);

  final Task task;
  final TaskDao dao;

  _onLongPressUpdate(BuildContext context, TaskDao dao, bool update, Task task) {
    displayDialog(context: context, dao: dao, update: update, task: task);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
      child: Card(
        elevation: 2.0,
        child: ListTile(
            onLongPress: () => _onLongPressUpdate(context, dao, true, task),
            title: Text(
              task.title,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            subtitle: Text(
              'created at  ${_formatDate(task.createdTime)}',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
            trailing: IconButton(
              onPressed: () async {
                await dao.deleteTask(task);
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('task  ${task.title} is removed')),
                );
              },
              icon: Icon(
                Icons.remove_circle,
                color: Colors.orange,
              ),
            )),
      ),
    );
  }
}
