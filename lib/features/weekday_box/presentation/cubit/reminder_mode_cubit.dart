import 'package:flutter_bloc/flutter_bloc.dart';

enum ReminderMode { all, selected }

class ReminderModeCubit extends Cubit<ReminderMode> {
  ReminderModeCubit() : super(ReminderMode.selected);

  void viewAll() => emit(ReminderMode.all);
  void viewSelected() => emit(ReminderMode.selected);
}
