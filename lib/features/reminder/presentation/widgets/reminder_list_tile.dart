import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/themes/app_themes.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder/presentation/form_launcher.dart';
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

  const ReminderListTile(this.reminder, this.parentContext, {super.key});

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
            color: currentTheme.shadowColor,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
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
            minTileHeight: 56,
            initiallyExpanded: false,
            shape: const Border(),
            // leading: IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.check_circle,
            //     size: 30,
            //     color: currentTheme.primaryColorAccent,
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
                                    Weekday.values[index],
                                  )
                                  ? currentTheme.activeColor
                                  : currentTheme.inactiveColor.withAlpha(100),
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
                            color: currentTheme.textColor,
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
              '${widget.reminder.time.hour}:${(widget.reminder.time.minute).toString().padLeft(2, '0')}',
              style: TextStyle(color: currentTheme.textColor, fontSize: 14),
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
                        color: currentTheme.textColor.withAlpha(120),
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
                            showReminderForm(
                              context,
                              ReminderFormType.edit,
                              'Editing',
                              submitCallback: (newReminder) {
                                widget.parentContext.read<ReminderBloc>().add(
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
                          color: currentTheme.activeColor,
                        ),
                        IconButton(
                          onPressed: () async {
                            await showConfirmationModal();
                          },
                          color: currentTheme.warningColor,
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

  Future<void> showConfirmationModal() async {
    showModalBottomSheet(
      showDragHandle: true,
      context: widget.parentContext,
      backgroundColor: currentTheme.backgroundOverlayColor,
      builder: (context) {
        return Confirmation(
          onConfirmCallback: () async {
            widget.parentContext.read<ReminderBloc>().add(
              DeleteReminderEvent(reminder: widget.reminder),
            );
            widget.parentContext.read<RemindersListBloc>().add(
              GetRemindersListEvent(),
            );
            Navigator.pop(context, true);
          },
          onCancelCallback: () async {
            Navigator.pop(context, true);
          },
        );
      },
    );
  }
}
