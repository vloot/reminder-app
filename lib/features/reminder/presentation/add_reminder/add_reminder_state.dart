class AddReminderState {}

class AddReminderInit extends AddReminderState {}

class AddReminderLoading extends AddReminderState {}

class AddReminderSuccess extends AddReminderState {}

class AddReminderFailure extends AddReminderState {
  final String errorMessage;

  AddReminderFailure(this.errorMessage);
}
