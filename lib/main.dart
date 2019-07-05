import 'package:floor_start/database/task_dao.dart';
import 'package:floor_start/screen/list_page.dart';
import 'package:flutter/material.dart';
import 'package:floor_start/database/database.dart';

Future<void> main() async {
  final database = await $FloorTaskDatabase
      .databaseBuilder('flutter_database.db')
      .build();
  final dao = database.taskDao;

  runApp(MyApp(dao));
}


class MyApp extends StatelessWidget {
  final TaskDao dao;

  const MyApp(this.dao);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     theme: ThemeData(
       brightness: Brightness.dark,
          primaryColor: Colors.deepPurple,
          accentColor: Colors.orange,
          errorColor: Colors.redAccent[100]),
      home: ListPage(title: 'Task with Floor',dao: dao),
    );
  }
}

