import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_todo_list/app/colors.dart';
import 'package:knowunity_todo_list/presentation/components/custom_calender_widget.dart';
import 'package:knowunity_todo_list/presentation/providers/home_screen_providers.dart';
import 'package:knowunity_todo_list/presentation/todo_list_body.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage({super.key});
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBlue,
        title: const Text(
          'Todo List',
          style: TextStyle(
              color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            color: AppColors.appBarBlue,
            child: const CustomCalenderWidget(),
          ),
          const Expanded(
            child: TodoListBody(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add a new todo'),
                content: TextField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(hintText: 'Todo description'),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  TextButton(
                    child: const Text('ADD'),
                    onPressed: () {
                      if (_textFieldController.text.isNotEmpty) {
                        // Call the add method from the TodoList provider
                        ref.read(todoListProvider.notifier).add(_textFieldController.text.trim());
                        _textFieldController.clear();
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: AppColors.lightPurple,
        tooltip: 'Increment',
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
