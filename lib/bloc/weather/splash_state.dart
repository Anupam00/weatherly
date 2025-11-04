part of 'splash_bloc.dart';

class SplashState extends Equatable{

  final SplashStatus splashStatus;

  const SplashState({
    this.splashStatus = SplashStatus.initial,
  });

  SplashState copyWith({SplashStatus? splashStatus}){
    return SplashState(
      splashStatus: splashStatus ?? this.splashStatus

    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [splashStatus];

}
