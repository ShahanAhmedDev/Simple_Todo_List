import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_todo_list/app/colors.dart';
import 'package:knowunity_todo_list/app/utils/common_functions.dart';
import 'package:knowunity_todo_list/presentation/components/middle_bar_containers.dart';
import 'package:knowunity_todo_list/presentation/components/todo_item.dart';
import 'package:knowunity_todo_list/presentation/providers/home_screen_providers.dart';

class TodoListBody extends ConsumerStatefulWidget {
  const TodoListBody({super.key});

  @override
  ConsumerState<TodoListBody> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<TodoListBody> {


  @override
  Widget build(BuildContext context) {
    final todosLeft = ref.watch(uncompletedTodosCount);
    final todos = ref.watch(filteredTodos);
    return Container(
      color: AppColors.appBarBlue,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MiddleBarContainers(
                    text: 'All',
                    isSelected: true,
                    type: TodoFilterType.all,
                  ),
                  MiddleBarContainers(
                      text: 'Completed',
                      isSelected: false,
                      type: TodoFilterType.completed),
                  MiddleBarContainers(
                      text: 'Left',
                      isSelected: false,
                      type: TodoFilterType.left
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('$todosLeft Items left',style: const TextStyle(fontWeight: FontWeight.bold,color: AppColors.white),),
            if (todos.isNotEmpty) const Divider(height: 10),
            for(var i= 0; i < todos.length; i++) ...[
              Dismissible(
                onDismissed: (_){
                  ref.read(todoListProvider.notifier).remove(todos[i]);
                },
                key: ValueKey(todos[i]),
                child: TodoItemContainer(
                  todoItem: todos[i],
                  title: todos[i].description.toString(),
                ),
              ),
            ],
            SizedBox(height: CommonFunctions.deviceHeight(context) * 0.3)
          ],
        ),
      ),
    );
  }
}
