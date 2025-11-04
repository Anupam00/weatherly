part of 'settings_bloc.dart';

class SettingsState extends Equatable{

  final String id;
  final String label;

  const SettingsState({
    this.id = '',
    this.label = '\u00B0C',

});

  SettingsState copyWith({String? id, String? label}){
    return SettingsState(
      id: id ?? this.id,
      label: label ?? this.label,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,label];

}