import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_event.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/reminder_mode_cubit.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/selected_days_cubit.dart';

class ViewSelector extends StatelessWidget {
  final Weekday today;
  final AppSettingsState settingsState;
  const ViewSelector({
    super.key,
    required this.today,
    required this.settingsState,
  });

  @override
  Widget build(BuildContext context) {
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
                          color: Color(
                            settingsState.settings.theme.shadowColor,
                          ),
                          spreadRadius: 0.1,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: Color(settingsState.settings.theme.secondaryColor),
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

                          context.read<RemindersListBloc>().add(
                            GetRemindersListEvent(),
                          );
                        }, mode == ReminderMode.all),
                        selectorButton('Selected only', () {
                          if (mode == ReminderMode.selected) return;

                          context.read<ReminderModeCubit>().viewSelected();
                          context.read<SelectedDaysCubit>().setSingle(today);

                          context.read<RemindersListBloc>().add(
                            GetRemindersDayListEvent({today}),
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
                  ? Color(settingsState.settings.theme.primaryColorAccent)
                  : Color(settingsState.settings.theme.transparent),
              color: Colors.transparent,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              shadows: <Shadow>[
                Shadow(
                  color: Color(settingsState.settings.theme.textColor),
                  offset: Offset(0, -5),
                ),
              ],
            ),
            duration: Duration(milliseconds: 100),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
