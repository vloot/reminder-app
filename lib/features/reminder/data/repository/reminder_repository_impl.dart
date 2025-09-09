import 'package:reminders_app/features/reminder/data/datasource/reminders_datasource.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/domain/repository/reminder_repository.dart';

class ReminderRepositoryImpl extends ReminderRepository {
  final RemindersDatasource datasource;

  ReminderRepositoryImpl({required this.datasource});

  @override
  Future<int> addReminder(ReminderModel reminder) async {
    reminder = reminder.copyWith(time: _setTime(reminder.time));
    return await datasource.addReminder(
      reminder,
    ); // TODO refactor this, so that datasource does not care about model
  }

  @override
  Future<ReminderModel> editReminder(ReminderModel reminder) {
    // TODO: implement editReminder
    throw UnimplementedError();
  }

  @override
  Future<ReminderModel> getReminder(int id) async {
    return await datasource.getReminder(id);
  }

  @override
  Future<List<ReminderModel>> getReminders() async {
    return await datasource.getReminders();
  }

  @override
  Future<ReminderModel> removeReminder(int id) async {
    // TODO: implement removeReminder
    throw UnimplementedError();
  }

  DateTime _setTime(DateTime time) {
    var notiTime = DateTime(2000);
    return notiTime.add(Duration(hours: time.hour, minutes: time.minute));
  }
}
