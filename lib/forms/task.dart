import 'package:flutter/material.dart';
import 'package:anxeb_flutter/anxeb.dart' as anxeb;
import 'package:todo_app/middleware/application.dart';
import 'package:todo_app/models/primary/task.dart';

class TaskForm extends anxeb.FormDialog<TaskModel, Application> {
  TaskModel _task;

  TaskForm({@required anxeb.Scope scope, TaskModel task})
      : super(
          scope,
          model: task,
          dismissable: true,
          title: task == null ? 'Nueva Tarea' : 'Editar Tarea',
          icon: task == null ? Icons.task : Icons.edit_square,
          width: double.maxFinite,
        ) ;

  @override
  void init(anxeb.FormScope scope) {
    _task = TaskModel();
    _task.update(model);
  }

  @override
  Widget body(anxeb.FormScope scope) {
    return Column(
      children: [
        anxeb.FormRowContainer(
          scope: scope,
          fields: [
            Expanded(
              child: anxeb.TextInputField(
                scope: scope,
                name: 'name',
                group: 'task',
                icon: Icons.title,
                fetcher: () => _task.name,
                label: 'Titulo',
                type: anxeb.TextInputFieldType.text,
                // validator: anxeb.Utils.validators.firstNames,
                applier: (value) => _task.name = value,
                autofocus: true,
              ),
            ),
            anxeb.FormSpacer(),
          ],
        ),
        anxeb.FormRowContainer(
          scope: scope,
          fields: [
            Expanded(
              child: anxeb.TextInputField(
                scope: scope,
                name: 'description',
                group: 'task',
                icon: Icons.subtitles,
                fetcher: () => _task.description,
                label: 'Descripción',
                type: anxeb.TextInputFieldType.text,
                // validator: anxeb.Utils.validators.firstNames,
                applier: (value) => _task.description = value,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  List<anxeb.FormButton> buttons(anxeb.FormScope<Application> scope) {
    return [
      anxeb.FormButton(
        visible: !exists,
        caption: 'Crear',
        onTap: (anxeb.FormScope scope) => _create(scope),
        icon: Icons.check,
      ),
      anxeb.FormButton(
        visible: exists,
        caption: 'Guardar',
        onTap: (anxeb.FormScope scope) => _persist(scope),
        icon: Icons.check,
      ),
            anxeb.FormButton(
        caption: exists ? 'Cerrar' : 'Cancelar',
        onTap: (anxeb.Scope scope) async => true,
        icon: Icons.close,
      )
    ];
  }


  Future _persist(anxeb.FormScope scope) async {
    final form = scope.forms['task'];
    if (form.valid(autoFocus: true)) {
      await _task.using(scope.parent).update(
        success: (helper) async {
          if (exists) {
            scope.parent.alerts
                .success('Tarea actualizada exitosamente')
                .show();
                      Navigator.of(scope.context);
            scope.parent.rasterize(() {
              model.update(_task);
            });
            
          } else {
            scope.parent.alerts.success('Tarea creada exitosamente').show();
          }
        },
      );
    }
  }

  Future _create(anxeb.FormScope scope) async {
    final form = scope.forms['task'];
    if (form.valid(autoFocus: true)) {
      await _task.using(scope.parent).insert(
        success: (helper) async {
            scope.parent.alerts
                .success('Tarea creada exitosamente')
                .show();
                      Navigator.of(scope.context);   
        },
      );
    }
  }

@override
  Future Function(anxeb.FormScope scope) get close => (scope) async => true;
}