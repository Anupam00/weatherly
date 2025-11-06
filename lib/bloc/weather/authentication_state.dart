part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable{
  final String apikey;
  final ValidationStatus validationStatus;
  final String message;

  const AuthenticationState({
    this.apikey = '',
    this.validationStatus = ValidationStatus.notValidated,
    this.message = '',
  });

  AuthenticationState copyWith({String? apikey,ValidationStatus? validationStatus,String? message, bool? isKeyStored}){
    return AuthenticationState(
      apikey: apikey ?? this.apikey,
      validationStatus: validationStatus ?? this.validationStatus,
      message: message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [apikey,validationStatus,message];
}
