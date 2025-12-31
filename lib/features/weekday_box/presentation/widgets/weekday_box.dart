import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/shared/weekday_info.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/reminder_mode_cubit.dart';
import 'package:reminders_app/features/weekday_box/presentation/widgets/day_circle.dart';
import 'package:reminders_app/features/weekday_box/presentation/widgets/view_selector.dart';

class WeekdayBox extends StatefulWidget {
  final Weekday today;
  final AppSettingsState settingsState;
  const WeekdayBox(this.today, this.settingsState, {super.key});

  @override
  _WeekdayBoxState createState() => _WeekdayBoxState();
}

class _WeekdayBoxState extends State<WeekdayBox> {
  @override
  Widget build(BuildContext context) {
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
                    ViewSelector(
                      today: widget.today,
                      settingsState: widget.settingsState,
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
                                      color: Color(
                                        widget
                                            .settingsState
                                            .settings
                                            .shadowColor,
                                      ),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  color: Color(
                                    widget
                                        .settingsState
                                        .settings
                                        .secondaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: buildDayCircles(constraints),
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

  Widget buildDayCircles(BoxConstraints constraints) {
    final mode = context.watch<ReminderModeCubit>().state;

    final days = getOrderedDays(widget.settingsState.settings.startingDay);
    final daysUI = List.generate(
      7,
      (index) => DayCircle(
        days[index].firstLetter(),
        days[index].weekday,
        widget.today,
        mode,
        constraints,
        widget.settingsState,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: daysUI,
    );
  }
}
