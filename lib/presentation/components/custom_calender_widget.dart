import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:knowunity_todo_list/app/colors.dart';

class CustomCalenderWidget extends StatelessWidget {
  const CustomCalenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
      EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (selectedDate) {
          // the new date selected.
        },
        activeColor: AppColors.lightPurple,
          headerProps: const EasyHeaderProps(showMonthPicker: false,centerHeader: true,selectedDateStyle: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold)),
        dayProps: EasyDayProps(
          height: 56.0,
          width: 56.0,

          dayStructure: DayStructure.dayNumDayStr,
          inactiveDayStyle:
          DayStyle(
            decoration: BoxDecoration(
              color: AppColors.lightWhite,
              borderRadius: const BorderRadius.all(Radius.circular(30),),
              border: Border.all(
                color: AppColors.grey,
              )
            ),
            borderRadius: 48.0,
            dayNumStyle: const TextStyle(
              fontSize: 16.0,

            ),
          ),
          todayStyle: DayStyle(
            decoration: BoxDecoration(
                color: AppColors.lightWhite,
                borderRadius: const BorderRadius.all(Radius.circular(30),),
                border: Border.all(
                  color: AppColors.darkPurple,
                  width: 1.5,
                )
            ),
            dayNumStyle: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          activeDayStyle: const DayStyle(
            borderRadius: 48.0,
            dayNumStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
                color: AppColors.black
              // color: AppColors.white
            ),
          ),
        ),
      );
  }
}
