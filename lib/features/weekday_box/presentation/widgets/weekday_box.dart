import 'package:flutter/material.dart';
import 'package:reminders_app/core/themes/themes.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';

class WeekdayBox extends StatelessWidget {
  const WeekdayBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildDailyBox();
  }

  Center buildDailyBox() {
    final today = DateTime.now().weekday - 1;
    final days = <Container>[
      buildDayCircle('M', isActive: today == Weekday.monday.index),
      buildDayCircle('T', isActive: today == Weekday.tuesday.index),
      buildDayCircle('W', isActive: today == Weekday.wednesday.index),
      buildDayCircle('T', isActive: today == Weekday.thursday.index),
      buildDayCircle('F', isActive: today == Weekday.friday.index),
      buildDayCircle('S', isActive: today == Weekday.saturday.index),
      buildDayCircle('S', isActive: today == Weekday.sunday.index),
    ];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 385,
            height: 100,
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: currentTheme.inactiveColor,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
                color: currentTheme.secondaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: days,
                ),
              ),
            ),
          ),
          SizedBox(height: 17),
        ],
      ),
    );
  }

  Container buildDayCircle(String label, {bool isActive = false}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          style: BorderStyle.solid,
          color: isActive
              ? currentTheme.primaryColorAccent
              : const Color.fromARGB(255, 210, 205, 205),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(2),
        child: CircleAvatar(
          backgroundColor: isActive
              ? currentTheme.primaryColorAccent
              : currentTheme.secondaryColor,
          radius: isActive ? 22 : 16, // resize radius
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: currentTheme.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
