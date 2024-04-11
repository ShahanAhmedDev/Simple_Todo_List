import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_todo_list/app/colors.dart';
import 'package:knowunity_todo_list/app/utils/common_functions.dart';
import 'package:knowunity_todo_list/data/models/todo.dart';
import 'package:knowunity_todo_list/presentation/providers/home_screen_providers.dart';

class TodoItemContainer extends ConsumerStatefulWidget {
  final String title;
  final Todo todoItem;
  // final Color color;

  TodoItemContainer({Key? key, required this.title, required this.todoItem,
    // required this.color
  }) : super(key: key);

  @override
  _TodoItemContainerState createState() => _TodoItemContainerState();
}

class _TodoItemContainerState extends ConsumerState<TodoItemContainer> {

  void _toggleChecked() {
      ref.read(todoListProvider.notifier).toggle(widget.todoItem.id);
  }

  @override
  Widget build(BuildContext context) {
    final isChecked = widget.todoItem.completed;
    return GestureDetector(
      onTap: _toggleChecked,
      child: Card(
        child: Container(
          width: CommonFunctions.deviceWidth(context) * 0.9,
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightPurple, width: 0.2),
            borderRadius: BorderRadius.circular(12.0),
            // color: widget.color,
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    decoration: isChecked ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2), // Padding around the checkbox
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isChecked ? AppColors.lightPurple : AppColors.lightWhite, // Checkbox background color
                    ),
                    child: SizedBox(
                      width: 24, // Set your desired width for Checkbox
                      height: 24, // Set your desired height for Checkbox
                      child: Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Colors.transparent, // Needed to make the checkbox's background transparent
                        ),
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            _toggleChecked();
                          },
                          activeColor: Colors.transparent, // Hiding the default active color
                          checkColor: Colors.black, // Color of the tick
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Remove extra tap target size
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
