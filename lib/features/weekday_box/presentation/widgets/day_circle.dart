import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_event.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/reminder_mode_cubit.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/selected_days_cubit.dart';

class DayCircle extends StatelessWidget {
  final BoxConstraints constraints;
  final String label;
  final Weekday weekday;
  final ReminderMode mode;
  final AppSettingsState settingsState;
  final bool isToday;

  const DayCircle(
    this.label,
    this.weekday,
    Weekday today,
    this.mode,
    this.constraints,
    this.settingsState, {
    super.key,
  }) : isToday = today == weekday;

  @override
  Widget build(BuildContext context) {
    final double size = isToday
        ? constraints.maxWidth * 0.13
        : constraints.maxWidth * 0.11;
    final double radius = 50;

    return BlocSelector<SelectedDaysCubit, SelectedDaysState, bool>(
      selector: (state) => state.selected.contains(weekday),
      builder: (context, containsThisDay) {
        Color borderColor = containsThisDay
            ? Color(settingsState.settings.theme.primaryColor)
            : Color(settingsState.settings.theme.inactiveColor);
        Color bgColor = isToday
            ? Color(settingsState.settings.theme.primaryColor)
            : Color(settingsState.settings.theme.secondaryColor);

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
                    color: Color(settingsState.settings.theme.secondaryColor),
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
                                  ? Color(
                                      settingsState
                                          .settings
                                          .theme
                                          .secondaryColor,
                                    )
                                  : Color(
                                      settingsState.settings.theme.textColor,
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
          ),
        );
      },
    );
  }
}
