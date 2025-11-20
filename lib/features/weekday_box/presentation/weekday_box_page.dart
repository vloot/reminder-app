import 'package:flutter/material.dart';
import 'package:reminders_app/core/themes/themes.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';

class WeekdayBox extends StatelessWidget {
  const WeekdayBox({Key? key}) : super(key: key);

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
        isActive: today == Weekday.monday.index,
      ),
      buildDayCircle(
        parentContext,
        'T',
        isActive: today == Weekday.tuesday.index,
      ),
      buildDayCircle(
        parentContext,
        'W',
        isActive: today == Weekday.wednesday.index,
      ),
      buildDayCircle(
        parentContext,
        'T',
        isActive: today == Weekday.thursday.index,
      ),
      buildDayCircle(
        parentContext,
        'F',
        isActive: today == Weekday.friday.index,
      ),
      buildDayCircle(
        parentContext,
        'S',
        isActive: today == Weekday.saturday.index,
      ),
      buildDayCircle(
        parentContext,
        'S',
        isActive: today == Weekday.sunday.index,
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
                    Container(
                      height: 138,
                      // color: Colors.lime,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 75),
                            child: Center(
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.only(bottom: 6.5),
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
                                    bottomLeft: Radius.circular(32),
                                    bottomRight: Radius.circular(32),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    selectorText('All        ', isActive: true),
                                    selectorText('Selected day'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            Positioned(
                              right: 7,
                              top: 5,
                              child: Icon(
                                size: 20,
                                Icons.settings,
                                color: currentTheme.inactiveColor,
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

  Text selectorText(String text, {bool isActive = false}) {
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
        Shadow(color: currentTheme.inactiveColor, offset: Offset(0, -5)),
      ],
    );
    return Text(text, style: textStyle);
  }

  Widget buildDayCircle(
    BuildContext parentContext,
    String label, {
    bool isActive = false,
  }) {
    final double size = isActive ? 52 : 46;
    final double radius = 50;
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isActive
              ? currentTheme.primaryColor
              : currentTheme.primaryColorAccent,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
          onPressed: () {
            // TODO add event
            // parentContext.read<WeekdayBoxBloc>().add()
            print('pressed $label');
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
                      color: isActive ? Colors.orange : Colors.white,
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
