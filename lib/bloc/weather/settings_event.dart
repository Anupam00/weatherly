part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable{
  const SettingsEvent();

  @override
  List<Object> get props =>[];
}

class DropDownTap extends SettingsEvent{
  final String id;
  final String label;

 const DropDownTap({
     required this.id,
    required this.label,
  });

  @override
  List<Object> get props =>[id,label];

}

class LogOutTap extends SettingsEvent{}