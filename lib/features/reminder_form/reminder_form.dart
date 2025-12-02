import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reminders_app/core/themes/app_themes.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder_form/reminder_form_type.dart';

class ReminderForm extends StatefulWidget {
  final ReminderFormType formType;
  final String title;
  final BuildContext parentContext;
  final void Function(ReminderModel newReminder) submitCallback;

  final ReminderModel? reminderModel;

  const ReminderForm(
    this.formType,
    this.title,
    this.parentContext,
    this.submitCallback, {
    this.reminderModel,
    super.key,
  });

  @override
  _ReminderFormState createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Set<Weekday> selectedDays = {};

  TimeOfDay _time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    if (widget.formType == ReminderFormType.edit &&
        widget.reminderModel != null) {
      _titleController.text = widget.reminderModel?.title ?? '';
      _descriptionController.text = widget.reminderModel?.description ?? '';
      _time = TimeOfDay.fromDateTime(
        widget.reminderModel?.time ?? DateTime.now(),
      );

      selectedDays.addAll(widget.reminderModel!.reminderDays);
    } else if (widget.formType == ReminderFormType.add) {
      selectedDays.addAll(<Weekday>{
        Weekday.monday,
        Weekday.tuesday,
        Weekday.wednesday,
        Weekday.thursday,
        Weekday.friday,
        Weekday.saturday,
        Weekday.sunday,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final keyboard = mq.viewInsets.bottom;
    return AnimatedPadding(
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: (mq.size.height - keyboard) * 0.65,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        '${widget.title} Reminder',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  createInput(
                    _titleController,
                    contentText: _titleController.text,
                    hintText: 'Title',
                    maxLines: 1,
                    maxLength: 38,
                    autofocus: widget.formType == ReminderFormType.add,
                  ),
                  createInput(
                    _descriptionController,
                    contentText: _descriptionController.text,
                    hintText: 'Description',
                  ),
                  buildTimeInput(context),

                  buildWeekdays(),
                  SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {
                      widget.submitCallback(
                        ReminderModel(
                          id: widget.reminderModel?.id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          time: DateTime(2000, 1, 1, _time.hour, _time.minute),
                          reminderDays: selectedDays,
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        currentTheme.primaryColor,
                      ),
                    ),
                    child: Text(
                      'Save reminder',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createInput(
    TextEditingController controller, {
    String? hintText,
    String? contentText,
    int maxLength = 128,
    int maxLines = 2,
    bool autofocus = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        maxLines: maxLines,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        cursorColor: Colors.amber,
        decoration: InputDecoration(
          labelText: hintText,
          hintFadeDuration: Duration(seconds: 1),
          contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          hoverColor: Colors.orangeAccent,
          focusColor: Colors.blueAccent,
          counterText: "",
        ),
      ),
    );
  }

  Widget buildTimeInput(BuildContext context) {
    final style = TextStyle(
      fontSize: 24,
      color: currentTheme.textColor,
      fontWeight: FontWeight.w600,
    );
    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      onPressed: () async {
        final time = await showTimePicker(
          initialEntryMode: TimePickerEntryMode.input,
          context: context,
          initialTime: _time,
        );
        setState(() {
          _time =
              time ??
              TimeOfDay.fromDateTime(
                widget.reminderModel?.time ?? DateTime.now(),
              );
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_time.hour.toString().padLeft(2, '0'), style: style),
          Text(":", style: style),
          Text(_time.minute.toString().padLeft(2, '0'), style: style),
          SizedBox(width: 20),
          Icon(
            Icons.more_time_rounded,
            fontWeight: FontWeight.bold,
            size: 24,
            color: currentTheme.textColor,
          ),
        ],
      ),
    );
  }

  Widget buildWeekdays() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildWeekdayButton(Weekday.monday, "MON"),
            buildWeekdayButton(Weekday.tuesday, "TUE"),
            buildWeekdayButton(Weekday.wednesday, "WED"),
            buildWeekdayButton(Weekday.thursday, "THU"),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildWeekdayButton(Weekday.friday, "FRI"),
            buildWeekdayButton(Weekday.saturday, "SAT"),
            buildWeekdayButton(Weekday.sunday, "SUN"),
          ],
        ),
      ],
    );
  }

  Widget buildWeekdayButton(Weekday weekday, String text) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ChoiceChip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(100),
        ),
        label: SizedBox(width: 35, child: Center(child: Text(text))),
        selected: selectedDays.contains(weekday),
        showCheckmark: false,
        selectedColor: Colors.greenAccent,
        disabledColor: Colors.blueGrey,
        onSelected: (value) {
          setState(() {
            if (value) {
              selectedDays.add(weekday);
            } else {
              selectedDays.remove(weekday);
            }
          });
        },
      ),
    );
  }
}
