// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorTaskDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TaskDatabaseBuilder databaseBuilder(String name) =>
      _$TaskDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TaskDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$TaskDatabaseBuilder(null);
}

class _$TaskDatabaseBuilder {
  _$TaskDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  /// Adds migrations to the builder.
  _$TaskDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Creates the database and initializes it.
  Future<TaskDatabase> build() async {
    final database = _$TaskDatabase();
    database.database = await database.open(name ?? ':memory:', _migrations);
    return database;
  }
}

class _$TaskDatabase extends TaskDatabase {
  _$TaskDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TaskDao _taskDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);
      },
      onCreate: (database, _) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Task` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `createdTime` INTEGER)');
      },
    );
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'Task',
            (Task item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'createdTime': item.createdTime
                },
            changeListener),
        _taskUpdateAdapter = UpdateAdapter(
            database,
            'Task',
            'id',
            (Task item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'createdTime': item.createdTime
                },
            changeListener),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'Task',
            'id',
            (Task item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'createdTime': item.createdTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _taskMapper = (Map<String, dynamic> row) =>
      Task(row['id'] as int, row['title'] as String, row['createdTime'] as int);

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final UpdateAdapter<Task> _taskUpdateAdapter;

  final DeletionAdapter<Task> _taskDeletionAdapter;

  @override
  Future<Task> findTaskById(int id) async {
    return _queryAdapter.query('SELECT * FROM task WHERE id = ?',
        arguments: <dynamic>[id], mapper: _taskMapper);
  }

  @override
  Future<List<Task>> findAllTasks() async {
    return _queryAdapter.queryList('SELECT * FROM task', mapper: _taskMapper);
  }

  @override
  Stream<List<Task>> findAllTasksAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM task',
        tableName: 'Task', mapper: _taskMapper);
  }

  @override
  Future<void> deleteAllTask() async {
    await _queryAdapter.queryNoReturn('DELETE FROM task');
  }

  @override
  Future<void> insertTask(Task task) async {
    await _taskInsertionAdapter.insert(task, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateTask(Task task) async {
    await _taskUpdateAdapter.update(task, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> deleteTask(Task task) async {
    await _taskDeletionAdapter.delete(task);
  }
}
