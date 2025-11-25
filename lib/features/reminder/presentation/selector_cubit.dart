import 'package:flutter_bloc/flutter_bloc.dart';

class WeekdayBoxUiCubit extends Cubit<bool> {
  WeekdayBoxUiCubit() : super(false);

  void toggleSelector() => emit(!state);
}
