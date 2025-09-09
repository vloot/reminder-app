import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';

extension ReminderModelX on ReminderModel {
  List<DateTime> getReminderDates() {
    final now = DateTime.now();
    return reminderDays.map((weekday) {
      var date = DateTime(now.year, now.month, now.day, time.hour, time.minute);

      while ((date.weekday - 1) != weekday.index) {
        date = date.add(Duration(days: 1));
      }

      return date;
    }).toList();
  }
}
