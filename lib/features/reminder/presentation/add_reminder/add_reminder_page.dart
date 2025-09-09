import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/infrastructure/dependency_injection.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder/presentation/add_reminder/add_reminder_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/add_reminder/add_reminder_event.dart';
import 'package:reminders_app/features/reminder/presentation/add_reminder/add_reminder_state.dart';

class AddReminderPage extends StatefulWidget {
  AddReminderPage({Key? key}) : super(key: key);

  @override
  _AddReminderPageState createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddReminderBloc>(
      create: (_) => getIt<AddReminderBloc>(),
      child: AddReminderWidget(),
    );
  }
}

class AddReminderWidget extends StatefulWidget {
  AddReminderWidget({Key? key}) : super(key: key);

  @override
  _AddReminderWidgetState createState() => _AddReminderWidgetState();
}

class _AddReminderWidgetState extends State<AddReminderWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Set<Weekday> selectedDays = {
    Weekday.monday,
    Weekday.tuesday,
    Weekday.wednesday,
    Weekday.thursday,
    Weekday.friday,
    Weekday.saturday,
    Weekday.sunday,
  };
  TimeOfDay _time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New reminder")),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              createInput(
                "Title",
                _titleController,
                maxLength: 38,
                maxLines: 1,
              ),
              createInput("Description", _descriptionController),
              buildTimeInput(context),
              buildWeekdays(),
              BlocListener<AddReminderBloc, AddReminderState>(
                listener: (context, state) {
                  if (state is AddReminderSuccess) {
                    print("success event cought");
                    Navigator.pop(context, true);
                  }
                },
                child: buildSubmitButtons(context),
              ),
            ],
          ),
        ),
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
            buildWeekdayButton(Weekday.friday, "FRI"),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
        label: Text(text),
        selected: selectedDays.contains(weekday),
        showCheckmark: false,
        selectedColor: Colors.greenAccent,
        disabledColor: Colors.blueGrey,
        onSelected: (value) {
          setState(() {
            if (value) {
              selectedDays.add(weekday);
              print('$weekday activated');
            } else {
              selectedDays.remove(weekday);
              print('$weekday deactivated');
            }
          });
        },
      ),
    );
  }

  Row buildSubmitButtons(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(90, 40)),
          onPressed: () {},
          child: Text("Cancel"),
        ),
        Container(width: 40),
        FilledButton(
          onPressed: () {
            final now = DateTime.now();
            context.read<AddReminderBloc>().add(
              SubmitReminderEvent(
                title: _titleController.text,
                description: _descriptionController.text,
                time: DateTime(
                  now.year,
                  now.month,
                  now.day,
                  _time.hour,
                  _time.minute,
                ),
                reminderDays: selectedDays,
              ),
            );
            print(
              "${_titleController.value.text} - ${_descriptionController.value.text}, ${selectedDays.length}, ${selectedDays.toString()}",
            );
          },
          style: FilledButton.styleFrom(minimumSize: const Size(90, 40)),
          child: Text("Save"),
        ),
      ],
    );
  }

  Row buildTimeInput(BuildContext context) {
    final style = TextStyle(fontSize: 32, color: Colors.lightGreen);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_time.hour.toString().padLeft(2, '0'), style: style),
        Text(":", style: style),
        Text(_time.minute.toString().padLeft(2, '0'), style: style),
        IconButton(
          onPressed: () async {
            final time = await showTimePicker(
              initialEntryMode: TimePickerEntryMode.input,
              context: context,
              initialTime: _time,
            );

            setState(() {
              _time = time ?? TimeOfDay.now();
            });
          },
          icon: Icon(Icons.more_time_rounded),
        ),
      ],
    );
  }

  Widget createInput(
    String hintText,
    TextEditingController controller, {
    int maxLength = 128,
    int maxLines = 2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextField(
        controller: controller,
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
}
