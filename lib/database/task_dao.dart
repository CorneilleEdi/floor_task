
import 'package:floor/floor.dart';
import 'package:floor_start/model/task.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM task WHERE id = :id')
  Future<Task> findTaskById(int id);

  @Query('SELECT * FROM task')
  Future<List<Task>> findAllTasks();

  @Query('SELECT * FROM task')
  Stream<List<Task>> findAllTasksAsStream();

  @insert
  Future<void> insertTask(Task task);

  @update
  Future<void> updateTask(Task task);

  @delete
  Future<void> deleteTask(Task task);

  @Query('DELETE FROM task')
  Future<void> deleteAllTask();
}