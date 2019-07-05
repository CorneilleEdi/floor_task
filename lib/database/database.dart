import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floor_start/database/task_dao.dart';
import 'package:floor_start/model/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version : 1, entities : [Task])
abstract class TaskDatabase extends FloorDatabase {
  TaskDao get taskDao;
}