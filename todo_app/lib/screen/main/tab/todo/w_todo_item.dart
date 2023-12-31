import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/get_it/get_it.dart';
import 'package:fast_app_base/common/widget/rounded_container.dart';
import 'package:fast_app_base/data/memory/todo_provider.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:fast_app_base/screen/main/write/vo_write_todo_result.dart';
import 'package:flutter/material.dart';

import 'w_todo_status.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final TodoProvider todoModel = getIt.get<TodoProvider>();

  TodoItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      margin: const EdgeInsets.only(bottom: 10),
      color: context.appColors.itemBackground,
      child: Dismissible(
        key: ValueKey(todo.id.toString()),
        background: getDismissibleBackground(context),
        onDismissed: (direction) => deleteTodo(),
        direction: DismissDirection.endToStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            todo.dueDate.relativeDays.text
                .size(12)
                .make()
                .pOnly(right: 10, left: 10),
            Row(
              children: [
                TodoStatusWidget(todo),
                Expanded(child: todo.title.text.size(20).medium.make()),
                IconButton(
                  onPressed: () => editTodo(context),
                  icon: const Icon(
                    EvaIcons.editOutline,
                  ),
                ),
              ],
            )
          ],
        ).pOnly(top: 10, right: 5, left: 5, bottom: 10),
      ),
    );
  }

  Widget getDismissibleBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.todoItemDelete,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Icon(
          EvaIcons.trash2Outline,
          color: context.appColors.dismissibleIcon,
        ),
      ).pOnly(right: 15),
    );
  }

  void editTodo(BuildContext context) async {
    final WriteTodoResult? result = await writeTodoBottomSheet(
      context,
      editTodo: todo,
    );

    if (result != null) {
      todoModel.editTodo(todo.copyWith(
        title: result.text,
        dueDate: result.dateTime,
      ));
    }
  }

  void deleteTodo() {
    todoModel.deleteTodo(todo);
  }
}
