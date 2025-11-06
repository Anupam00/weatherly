part of 'splash_bloc.dart';

class SplashState extends Equatable{

  final SplashStatus splashStatus;
  final ValidationStatus validationStatus;
  final String message;
  final bool isKeyStored;

  const SplashState({
    this.splashStatus = SplashStatus.initial,
    this.validationStatus = ValidationStatus.notValidated,
    this.message = '',
    this.isKeyStored = false,
  });

  SplashState copyWith({SplashStatus? splashStatus,ValidationStatus? validationStatus,String? message, bool? isKeyStored}){
    return SplashState(
      splashStatus: splashStatus ?? this.splashStatus,
      validationStatus: validationStatus ?? this.validationStatus,
      message: message ?? this.message,
      isKeyStored: isKeyStored ?? this.isKeyStored,
    );
  }

  @override
  List<Object?> get props => [splashStatus,validationStatus,message,isKeyStored];

}
