import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/form_launcher.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_event.dart';
import 'package:reminders_app/features/reminder_form/reminder_form_type.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';
import 'package:reminders_app/l10n/app_localizations.dart';

class ListHeader extends StatefulWidget {
  final AppSettingsState settingsState;
  const ListHeader({super.key, required this.settingsState});

  @override
  _ListHeaderState createState() => _ListHeaderState();
}

class _ListHeaderState extends State<ListHeader> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 40,
        child: TextButton(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          onPressed: () async {
            showReminderForm(
              context,
              ReminderFormType.add,
              l10n.addReminder,
              widget.settingsState,
              submitCallback: (reminderModel) async {
                context.read<ReminderBloc>().add(
                  AddReminderEvent(
                    title: reminderModel.title,
                    description: reminderModel.description ?? '',
                    time: reminderModel.time,
                    reminderDays: reminderModel.reminderDays,
                  ),
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.addReminder,
                  style: TextStyle(
                    color: Color(widget.settingsState.settings.theme.textColor),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.add,
                  color: Color(widget.settingsState.settings.theme.textColor),
                  fontWeight: FontWeight.bold,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
