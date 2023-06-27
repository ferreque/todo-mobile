import 'package:anxeb_flutter/anxeb.dart' as anxeb;
import 'package:todo_app/helpers/task.dart';

class TaskModel extends anxeb.HelpedModel<TaskModel, TaskHelper> {
  TaskModel([data]) : super(data);

  @override
  void init() {
    field(() => id, (v) => id = v, 'id', primary: true);
    field(() => name, (v) => name = v, 'name');
    field(() => description, (v) => description = v, 'description');
    field(() => user, (v) => user = v, 'user');
  }

  String id;
  String name;
  String description;
  String user;

  @override
  TaskHelper helper() => TaskHelper();

  String get fullName => name;
}
