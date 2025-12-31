import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reminders_app/core/shared/weekday_info.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/presentation/form_launcher.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_event.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/widgets/confirmation.dart';
import 'package:reminders_app/features/reminder_form/reminder_form_type.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';

class ReminderListTile extends StatefulWidget {
  final List<WeekdayInfo> days;
  final String timeFormat;
  final ReminderModel reminder;
  final AppSettingsState settingsState;

  const ReminderListTile(
    this.reminder,
    this.settingsState, {
    super.key,
    required this.days,
    required this.timeFormat,
  });

  @override
  _ReminderListTileState createState() => _ReminderListTileState();
}

class _ReminderListTileState extends State<ReminderListTile> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(widget.settingsState.settings.theme.secondaryColor),
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(widget.settingsState.settings.theme.shadowColor),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: ExpansionTile(
            minTileHeight: 56,
            initiallyExpanded: false,
            shape: const Border(),
            // leading: IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.check_circle,
            //     size: 30,
            //     color: Color(widget.settingsState.settings.theme.primaryColorAccent),
            //   ),
            // ),
            title: Container(
              // HACK padding is used because leading checkbox button isn't implemented yet
              padding: const EdgeInsets.only(left: 20),
              child: Transform.translate(
                offset: Offset(0, -5),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(height: 50),
                    Positioned(
                      left: -10,
                      bottom: 0,
                      child: Row(
                        spacing: 6,
                        children: List.generate(7, (index) {
                          final size = 6.5;
                          return Container(
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  widget.reminder.reminderDays.contains(
                                    widget.days[index].weekday,
                                  )
                                  ? Color(
                                      widget
                                          .settingsState
                                          .settings
                                          .theme
                                          .activeColor,
                                    )
                                  : Color(
                                      widget
                                          .settingsState
                                          .settings
                                          .theme
                                          .inactiveColor,
                                    ).withAlpha(100),
                            ),
                          );
                        }),
                      ),
                    ),
                    Positioned.fill(
                      left: -10,
                      child: Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(
                          widget.reminder.title,
                          style: TextStyle(
                            color: Color(
                              widget.settingsState.settings.theme.textColor,
                            ),
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            trailing: Text(
              // IDEA add clock emoji before or after time
              DateFormat(widget.timeFormat).format(widget.reminder.time),
              style: TextStyle(
                color: Color(widget.settingsState.settings.theme.textColor),
                fontSize: 14,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 5,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(
                          widget.settingsState.settings.theme.textColor,
                        ).withAlpha(120),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        widget.reminder.description ?? '',
                        style: TextStyle(
                          color: Color(
                            widget.settingsState.settings.theme.textColor,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            showReminderForm(
                              context,
                              ReminderFormType.edit,
                              'Editing',
                              widget.settingsState,
                              submitCallback: (newReminder) {
                                // FIXME bug somewhere here, in which editing reminder breaks selection
                                context.read<ReminderBloc>().add(
                                  EditReminderEvent(
                                    id: newReminder.id!,
                                    title: newReminder.title,
                                    description: newReminder.description ?? '',
                                    time: newReminder.time,
                                    reminderDays: newReminder.reminderDays,
                                  ),
                                );
                              },
                              reminderModel: widget.reminder,
                            );
                          },
                          icon: Icon(Icons.edit_note_rounded),
                          color: Color(
                            widget.settingsState.settings.theme.activeColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await showConfirmationModal(
                              context.read<RemindersListBloc>(),
                            );
                          },
                          color: Color(
                            widget.settingsState.settings.theme.warningColor,
                          ),
                          icon: Icon(Icons.delete_outline_sharp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showConfirmationModal(RemindersListBloc bloc) async {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      backgroundColor: Color(
        widget.settingsState.settings.theme.backgroundOverlayColor,
      ),
      builder: (_) {
        return Confirmation(
          settingsState: widget.settingsState,
          onConfirmCallback: () async {
            context.read<ReminderBloc>().add(
              DeleteReminderEvent(reminder: widget.reminder),
            );
            Navigator.pop(context);
          },
          onCancelCallback: () async {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
