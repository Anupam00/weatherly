import 'package:WeatherApp/utils/storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final FlutterStorage flutterStorage = FlutterStorage();
  SettingsBloc() : super(SettingsState()) {
    on<DropDownTap>(_optionSelected);
    on<LogOutTap>(_logout);
  }

  void _optionSelected(DropDownTap event , Emitter<SettingsState> emit){
    emit(state.copyWith(
        id: event.id,
        label: event.label),
    );
  }

  void _logout(LogOutTap event , Emitter<SettingsState> emit){
    flutterStorage.deleteStorage();
    emit(state.copyWith(
      sessionActive: false,
    ));




  }


}
