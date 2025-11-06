import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/themes/themes.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_event.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_event.dart';
import 'package:reminders_app/features/reminder/presentation/widgets/confirmation.dart';
import 'package:reminders_app/features/reminder_form/reminder_form.dart';
import 'package:reminders_app/features/reminder_form/reminder_form_type.dart';

class ReminderListTile extends StatefulWidget {
  final ReminderModel reminder;
  final BuildContext parentContext;
  final BuildContext innerContext;

  ReminderListTile(
    this.reminder,
    this.parentContext,
    this.innerContext, {
    super.key,
  });

  @override
  _ReminderListTileState createState() => _ReminderListTileState();
}

class _ReminderListTileState extends State<ReminderListTile> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: currentTheme.secondaryColor,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Theme(
          data: Theme.of(widget.parentContext).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: ExpansionTile(
            initiallyExpanded: false,
            shape: const Border(),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check_circle,
                size: 30,
                color: currentTheme.primaryColorAccent,
              ),
            ),
            title: Text(widget.reminder.title),
            trailing: Text(
              '${widget.reminder.time.hour}:${(widget.reminder.time.minute).toString().padLeft(2, '0')}',
              style: TextStyle(color: currentTheme.textColor, fontSize: 14),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black12, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        widget.reminder.description ?? '',
                        style: TextStyle(
                          color: currentTheme.textColor,
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
                            showModalBottomSheet(
                              context: widget.parentContext,
                              showDragHandle: true,
                              builder: (context) {
                                return ReminderForm(
                                  ReminderFormType.edit,
                                  'Editing',
                                  widget.parentContext,
                                  (newReminder) {
                                    widget.innerContext
                                        .read<ReminderBloc>()
                                        .add(
                                          EditReminderEvent(
                                            id: newReminder.id!,
                                            title: newReminder.title,
                                            description:
                                                newReminder.description ?? '',
                                            time: newReminder.time,
                                            reminderDays:
                                                newReminder.reminderDays,
                                          ),
                                        );
                                  },
                                  reminderModel: widget.reminder,
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.edit_note_rounded),
                          color: Colors.green,
                        ),
                        IconButton(
                          onPressed: () async {
                            showModalBottomSheet(
                              context: widget.parentContext,
                              builder: (context) {
                                return Confirmation(
                                  () async {
                                    // BlocListener()
                                    print('confirm');
                                    widget.innerContext
                                        .read<ReminderBloc>()
                                        .add(
                                          DeleteReminderEvent(
                                            reminder: widget.reminder,
                                          ),
                                        );
                                    print('after event');
                                    widget.parentContext
                                        .read<RemindersListBloc>()
                                        .add(GetRemindersListEvent());
                                  },
                                  () async {
                                    print('cancel');
                                  },
                                );
                              },
                            );
                          },
                          color: Colors.redAccent,
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
}
