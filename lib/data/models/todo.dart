import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';

const _uuid = Uuid();

/// A read-only description of a todo-item
class Todo {
  const Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool completed;

  @override
  String toString() {
    return 'Todo(description: $description, completed: $completed)';
  }
}

/// An object that controls a list of Todo.
class TodoList extends Notifier<List<Todo>> {
  TodoList() : super() {
    _fetchInitialTodos();
  }

  Future<void> _fetchInitialTodos() async {
    final dio = Dio();
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/todos');
      final List<dynamic> todosJson = response.data as List<dynamic>;
      state =  todosJson.take(10).map((jsonTodo) {
        return Todo(
          id: _uuid.v4(), // Generating a new ID for each todo
          description: jsonTodo['title'],
          completed: jsonTodo['completed'],
        );
      }).toList();
    } catch (e) {
      // Handle errors, maybe by setting the state to a list containing an error Todo
      state = [Todo(id: _uuid.v4(), description: 'Failed to fetch todos')];
    }
  }


  ///By default have 3 todo objects
  @override
  List<Todo> build() => [
    const Todo(id: 'todo-1', description: 'Smile'),
    const Todo(id: 'todo-2', description: 'Stay Strong'),
    const Todo(id: 'todo-3', description: 'Have a good Time'),
  ];

  ///to add a new todo object
  void add(String description) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  ///to mark it complete
  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
          )
        else
          todo,
    ];
  }

  ///to remove it
  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
