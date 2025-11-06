part of 'settings_bloc.dart';

class SettingsState extends Equatable{

  final String id;
  final String label;
  final bool sessionActive;

  const SettingsState({
    this.id = '',
    this.label = '\u00B0C',
    this.sessionActive = true,

});

  SettingsState copyWith({String? id, String? label,bool? sessionActive}){
    return SettingsState(
      id: id ?? this.id,
      label: label ?? this.label,
      sessionActive: sessionActive ?? this.sessionActive,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,label,sessionActive];

}