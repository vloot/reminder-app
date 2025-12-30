import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/infrastructure/dependency_injection.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_event.dart';
import 'package:reminders_app/features/reminder/presentation/widgets/app_bar.dart';
import 'package:reminders_app/features/reminder/presentation/widgets/list_header.dart';
import 'package:reminders_app/features/reminder/presentation/widgets/reminders_list.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_bloc.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/reminder_mode_cubit.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/selected_days_cubit.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  Weekday today = Weekday.monday;

  @override
  void initState() {
    super.initState();
    today = Weekday.values[DateTime.now().weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<RemindersListBloc>()
                ..add(GetRemindersDayListEvent({today})),
        ),
        BlocProvider(create: (_) => getIt<ReminderBloc>()),
        BlocProvider(create: (_) => SelectedDaysCubit(today)),
        BlocProvider(create: (_) => ReminderModeCubit()),
      ],

      child: Builder(
        builder: (context) {
          return BlocBuilder<AppSettingsBloc, AppSettingsState>(
            builder: (context, settingsState) {
              return Scaffold(
                backgroundColor: Color(settingsState.settings.backgroundColor),
                body: CustomScrollView(
                  slivers: [
                    ReminderAppBar(settingsState: settingsState, today: today),
                    ListHeader(settingsState: settingsState),
                    RemindersList(settingsState: settingsState),

                    // add some space at the bottom
                    SliverToBoxAdapter(child: SizedBox(height: 50)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
