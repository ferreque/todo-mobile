import 'package:flutter/material.dart';
import 'package:todo_app/models/primary/task.dart';

class ListTasks extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function(TaskModel) onSelectTask;
  final Function(TaskModel) onDeleteTask;
  final Function(TaskModel) onDismissedTask;

  const ListTasks({
    Key key,
    this.tasks,
    this.onSelectTask,
    this.onDeleteTask,
    this.onDismissedTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        final task = tasks[index];
        return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              onDismissedTask(task);
            },
            background: Container(color: Colors.red),
            child: Card(
              child: GestureDetector(
                child: TaskTile(
                  task: task,
                  onSelectTask: onSelectTask,
                  onDeleteTask: onDeleteTask,
                ),
              ),
            ));
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final Function(TaskModel) onSelectTask;
  final Function(TaskModel) onDeleteTask;

  const TaskTile({
    Key key,
    this.task,
    this.onSelectTask,
    this.onDeleteTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          task.user,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        ListTile(
          title: Text(
            task.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(task.description),
          onTap: () {
            onSelectTask(task);
          },
          trailing: IconButton(
            onPressed: () => onDeleteTask(task),
            icon: const Icon(Icons.delete),
            color: Colors.pink,
          ),
        ),
      ],
    );
  }
}
