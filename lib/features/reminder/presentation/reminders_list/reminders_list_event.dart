import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';

abstract class RemindersListEvent {}

class GetRemindersListEvent extends RemindersListEvent {}

class GetRemindersDayListEvent extends RemindersListEvent {
  Set<Weekday> weekdaysSet;

  GetRemindersDayListEvent(this.weekdaysSet);
}
