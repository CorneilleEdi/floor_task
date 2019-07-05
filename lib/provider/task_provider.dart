import 'package:floor_start/database/task_dao.dart';
import 'package:floor_start/model/task.dart';
import 'package:flutter/foundation.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks;
  TaskDao dao;

  TaskProvider(this.dao, this._tasks){
    addAllTask();
  }

  getTasks() => _tasks;

  addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  Future addAllTask() async{
    await dao.findAllTasks().then((tasks){
      _tasks.addAll(tasks);
      notifyListeners();
    });

  }

  updateTask(Task task, int position) {
    _tasks[position] = task;
    notifyListeners();
  }

  removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  removeAllTask() async {
    await dao.deleteAllTask();
    _tasks = [];
    notifyListeners();
  }
}
