import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_todo_list/data/models/todo.dart';

///An enum type for different list filters.
enum TodoFilterType { all, completed, left }

///We create a State Notifier Provider that takes the notifier from the todo.dart
///and then creates its state notifer instance here(So we can use it in the ui).
final todoListProvider = NotifierProvider<TodoList, List<Todo>>(TodoList.new);

///This provider tracks the current active filter. default set to All.
final selectedTodoListFilter = StateProvider((_) {
  return TodoFilterType.all; // Default selection
});

/// this provider keeps track of how many tasks remain in the list
final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});



final filteredTodos =  Provider<List<Todo>>((ref) {
  final totalTodos = ref.watch(todoListProvider);
  final filter = ref.watch(selectedTodoListFilter);

  switch (filter) {
    case TodoFilterType.all:
      return totalTodos;
    case TodoFilterType.completed:
      return totalTodos.where((todo) => todo.completed).toList();
    case TodoFilterType.left:
      return totalTodos.where((todo) => !todo.completed).toList();
  }
});