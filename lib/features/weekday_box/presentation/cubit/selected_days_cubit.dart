import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';

class SelectedDaysCubit extends Cubit<SelectedDaysState> {
  SelectedDaysCubit(Weekday initialDay)
    : super(SelectedDaysState({initialDay}));

  void toggle(Weekday day) {
    final next = Set<Weekday>.from(state.selected);
    next.contains(day) ? next.remove(day) : next.add(day);
    emit(SelectedDaysState(next));
  }

  void setMultiple(Set<Weekday> days) {
    emit(SelectedDaysState(days));
  }

  void setSingle(Weekday day) {
    emit(SelectedDaysState({day}));
  }

  void clearSelection() {
    emit(SelectedDaysState({}));
  }

  void setAll() {
    emit(
      SelectedDaysState({
        Weekday.monday,
        Weekday.tuesday,
        Weekday.wednesday,
        Weekday.thursday,
        Weekday.friday,
        Weekday.saturday,
        Weekday.sunday,
      }),
    );
  }

  bool isSelected(Weekday day) => state.selected.contains(day);
}

class SelectedDaysState {
  final Set<Weekday> selected;

  const SelectedDaysState(this.selected);
}
