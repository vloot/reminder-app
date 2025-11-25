import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/themes/themes.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_event.dart';

class WeekdayBox extends StatefulWidget {
  final Weekday weekday;
  WeekdayBox(this.weekday, {Key? key}) : super(key: key);

  @override
  _WeekdayBoxState createState() => _WeekdayBoxState();
}

class _WeekdayBoxState extends State<WeekdayBox> {
  final Set<Weekday> selectedDays = {};

  @override
  Widget build(BuildContext context) {
    return buildDailyBox(context);
  }

  Widget buildDailyBox(BuildContext parentContext) {
    final today = DateTime.now().weekday - 1;
    final days = <Widget>[
      buildDayCircle(
        parentContext,
        'M',
        Weekday.monday,
        isToday: today == Weekday.monday.index,
      ),
      buildDayCircle(
        parentContext,
        'T',
        Weekday.tuesday,
        isToday: today == Weekday.tuesday.index,
      ),
      buildDayCircle(
        parentContext,
        'W',
        Weekday.wednesday,
        isToday: today == Weekday.wednesday.index,
      ),
      buildDayCircle(
        parentContext,
        'T',
        Weekday.thursday,
        isToday: today == Weekday.thursday.index,
      ),
      buildDayCircle(
        parentContext,
        'F',
        Weekday.friday,
        isToday: today == Weekday.friday.index,
      ),
      buildDayCircle(
        parentContext,
        'S',
        Weekday.saturday,
        isToday: today == Weekday.saturday.index,
      ),
      buildDayCircle(
        parentContext,
        'S',
        Weekday.sunday,
        isToday: today == Weekday.sunday.index,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    buildViewSelector(context),
                    Positioned(
                      top: 0,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: Stack(
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * 0.92,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: days,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildViewSelector(BuildContext parentContext) {
    return SizedBox(
      height: 145,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 75, right: 75),
            child: Center(
              child: Container(
                height: 100,
                padding: EdgeInsets.only(bottom: 0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: currentTheme.inactiveColor,
                      spreadRadius: 0.1,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ],
                  color: currentTheme.secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    selectorButton(
                      'All',
                      () => parentContext.read<RemindersListBloc>().add(
                        GetRemindersListEvent(),
                      ),
                      isActive: false,
                    ),
                    selectorButton('Selected day', () => {}, isActive: true),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextButton selectorButton(
    String text,
    void Function() onPressed, {
    bool isActive = false,
  }) {
    final textStyle = TextStyle(
      decoration: TextDecoration.combine([TextDecoration.underline]),
      decorationThickness: 3,
      decorationColor: isActive
          ? currentTheme.primaryColorAccent
          : currentTheme.transparent,
      color: Colors.transparent,
      fontSize: 15,
      fontWeight: FontWeight.w700,
      shadows: <Shadow>[
        Shadow(color: currentTheme.textColor, offset: Offset(0, -5)),
      ],
    );

    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [Text(text, style: textStyle)],
      ),
    );
  }

  Widget buildDayCircle(
    BuildContext parentContext,
    String label,
    Weekday weekday, {
    bool isToday = false,
  }) {
    final double size = isToday ? 52 : 46;
    final double radius = 50;
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isToday
              ? currentTheme.primaryColor
              : currentTheme.primaryColorAccent,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
          onPressed: () {
            if (selectedDays.contains(weekday)) {
              selectedDays.remove(weekday);
            } else {
              selectedDays.add(weekday);
            }

            setState(() {});

            parentContext.read<RemindersListBloc>().add(
              GetRemindersDayListEvent(selectedDays),
            );
          },
          child: SizedBox(
            width: size - 5,
            height: size - 5,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: SizedBox(
                width: size - 8,
                height: size - 8,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isToday ? Colors.orange : Colors.white,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: currentTheme.textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
