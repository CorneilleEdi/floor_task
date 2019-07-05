import 'package:floor/floor.dart';
@entity
class Task {
  @PrimaryKey(autoGenerate: true)
  final int id;

  String title;
  final int createdTime;

  Task(this.id, this.title,this.createdTime);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  @override
  String toString() => 'Task {id : $id, title : $title,created at : $createdTime}';
}
