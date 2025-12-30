import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/shared/request_status.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_state.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_event.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_state.dart';
import 'package:reminders_app/features/reminder/presentation/widgets/reminder_list_tile.dart';
import 'package:reminders_app/features/reminder/presentation/widgets/shimmer_tile.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/reminder_mode_cubit.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/selected_days_cubit.dart';

class RemindersList extends StatefulWidget {
  final AppSettingsState settingsState;

  const RemindersList({super.key, required this.settingsState});

  @override
  _RelindersListState createState() => _RelindersListState();
}

class _RelindersListState extends State<RemindersList> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ReminderBloc, ReminderState>(
          listenWhen: (previous, current) =>
              current is ReminderAdded ||
              current is ReminderEdited ||
              current is ReminderDeleted,
          listener: (context, state) {
            // Navigator.of(context, rootNavigator: true).pop();
            var viewMode = context.read<ReminderModeCubit>().state;
            if (viewMode == ReminderMode.all) {
              context.read<RemindersListBloc>().add(GetRemindersListEvent());
              return;
            }

            final selectedDays = context
                .read<SelectedDaysCubit>()
                .state
                .selected;

            if (state is ReminderAdded) {
              // make sure new reminder is visible
              selectedDays.addAll(state.reminder.reminderDays);
              context.read<SelectedDaysCubit>().setMultiple(selectedDays);
            }

            // all other cases are unchanged
            context.read<RemindersListBloc>().add(
              GetRemindersDayListEvent(selectedDays),
            );
          },
        ),
      ],
      child: BlocBuilder<RemindersListBloc, RemindersListState>(
        builder: (context, state) {
          if (state.status == RequestStatus.init) {
            return SliverToBoxAdapter(child: SizedBox.shrink());
          } else if (state.status == RequestStatus.loading) {
            return SliverList(delegate: shimmerDelegate());
          } else if (state.status == RequestStatus.error) {
            return SliverToBoxAdapter(
              child: Center(child: Text(state.errorMessage ?? 'Unknown error')),
            );
          } else if (state.status == RequestStatus.done) {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: ReminderListTile(
                    state.reminders![index],
                    widget.settingsState,
                  ),
                );
              }, childCount: state.reminders?.length ?? 0),
            );
          }
          return SliverToBoxAdapter(child: Text("Unknown error"));
        },
      ),
    );
  }

  SliverChildBuilderDelegate shimmerDelegate() {
    return SliverChildBuilderDelegate(
      (context, index) => const ShimmerTile(),
      childCount: 4,
    );
  }
}
