import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_todo_list/app/colors.dart';
import 'package:knowunity_todo_list/presentation/providers/home_screen_providers.dart';

class MiddleBarContainers extends ConsumerWidget {
  final String text;
  final bool isSelected;
  final TodoFilterType type;


  const MiddleBarContainers({
    super.key,
    required this.text,
    required this.isSelected,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isSelected = ref.watch(selectedTodoListFilter) == type;

    return GestureDetector(
      onTap: (){
        ref.read(selectedTodoListFilter.notifier).state = type;
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20),),
          border: isSelected? null: Border.all(
            color: AppColors.white, // Set the color of the border
            width: 1, // Set the width of the border
          ),
          color: isSelected ? AppColors.lightPurple: AppColors.white,
        ),
        child: Text(
          text,style: TextStyle(fontSize: 14,color: isSelected? AppColors.grey: AppColors.textGrey,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
