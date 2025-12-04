import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/themes/app_themes.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_event.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/reminder_mode_cubit.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/selected_days_cubit.dart';

class WeekdayBox extends StatefulWidget {
  final Weekday today;
  WeekdayBox(this.today, {Key? key}) : super(key: key);

  @override
  _WeekdayBoxState createState() => _WeekdayBoxState();
}

class _WeekdayBoxState extends State<WeekdayBox> {
  @override
  Widget build(BuildContext context) {
    return buildDailyBox(context);
  }

  Widget buildDailyBox(BuildContext parentContext) {
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
                                      color: currentTheme.shadowColor,
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
                                  child: buildDayCircles(
                                    parentContext,
                                    constraints,
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

  Widget buildDayCircles(
    BuildContext parentContext,
    BoxConstraints constraints,
  ) {
    final mode = context.watch<ReminderModeCubit>().state;

    // final mode = ReminderMode.selected;

    final days = [
      buildDayCircle(parentContext, 'M', Weekday.monday, mode, constraints),
      buildDayCircle(parentContext, 'T', Weekday.tuesday, mode, constraints),
      buildDayCircle(parentContext, 'W', Weekday.wednesday, mode, constraints),
      buildDayCircle(parentContext, 'T', Weekday.thursday, mode, constraints),
      buildDayCircle(parentContext, 'F', Weekday.friday, mode, constraints),
      buildDayCircle(parentContext, 'S', Weekday.saturday, mode, constraints),
      buildDayCircle(parentContext, 'S', Weekday.sunday, mode, constraints),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: days,
    );
  }

  Widget buildViewSelector(BuildContext parentContext) {
    final mode = context.watch<ReminderModeCubit>().state;

    return BlocBuilder<SelectedDaysCubit, SelectedDaysState>(
      builder: (context, state) {
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
                          color: currentTheme.shadowColor,
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
                        selectorButton('All', () {
                          if (mode == ReminderMode.all) return;

                          context.read<SelectedDaysCubit>().clearSelection();
                          context.read<SelectedDaysCubit>().setAll();
                          context.read<ReminderModeCubit>().viewAll();

                          parentContext.read<RemindersListBloc>().add(
                            GetRemindersListEvent(),
                          );
                        }, mode == ReminderMode.all),
                        selectorButton('Selected only', () {
                          if (mode == ReminderMode.selected) return;

                          context.read<ReminderModeCubit>().viewSelected();
                          context.read<SelectedDaysCubit>().setSingle(
                            widget.today,
                          );

                          parentContext.read<RemindersListBloc>().add(
                            GetRemindersDayListEvent({widget.today}),
                          );
                        }, mode == ReminderMode.selected),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  TextButton selectorButton(
    String text,
    void Function() onPressed,
    bool isActive,
  ) {
    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedDefaultTextStyle(
            style: TextStyle(
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
            ),
            duration: Duration(milliseconds: 100),
            child: Text(text),
          ),
        ],
      ),
    );
  }

  Widget buildDayCircle(
    BuildContext parentContext,
    String label,
    Weekday weekday,
    ReminderMode mode,
    BoxConstraints constraints,
  ) {
    final bool isToday = widget.today == weekday;
    final double size = isToday
        ? constraints.maxWidth * 0.13
        : constraints.maxWidth * 0.11;
    final double radius = 50;

    return BlocSelector<SelectedDaysCubit, SelectedDaysState, bool>(
      selector: (state) => state.selected.contains(weekday),
      builder: (context, containsThisDay) {
        Color borderColor = containsThisDay
            ? currentTheme.primaryColor
            : currentTheme.inactiveColor;
        Color bgColor = isToday
            ? currentTheme.primaryColor
            : currentTheme.secondaryColor;

        return SizedBox(
          width: size,
          height: size,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              border: BoxBorder.all(
                width: containsThisDay ? 3.5 : 1.5,
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
              onPressed: () {
                final selectedDays = context
                    .read<SelectedDaysCubit>()
                    .state
                    .selected;
                final isSelected = selectedDays.contains(weekday);

                if (selectedDays.length == 1 &&
                    selectedDays.firstOrNull == weekday) {
                  // do not toggle last day
                  return;
                }

                if (isSelected && mode == ReminderMode.all) {
                  context.read<ReminderModeCubit>().viewSelected();
                }

                context.read<SelectedDaysCubit>().toggle(weekday);

                context.read<RemindersListBloc>().add(
                  GetRemindersDayListEvent(
                    context.read<SelectedDaysCubit>().state.selected,
                  ),
                );
              },
              child: SizedBox(
                width: size - 5,
                height: size - 5,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: currentTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: SizedBox(
                    width: size - 8,
                    height: size - 8,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        child: Center(
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: isToday
                                  ? currentTheme.secondaryColor
                                  : currentTheme.textColor,
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
      },
    );
  }
}
