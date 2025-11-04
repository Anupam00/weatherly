import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState()) {
    on<DropDownTap>(_optionSelected);
  }

  void _optionSelected(DropDownTap event , Emitter<SettingsState> emit){
    emit(state.copyWith(
        id: event.id,
        label: event.label),
    );
  }
}
