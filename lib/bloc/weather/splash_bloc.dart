import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/auth_repository.dart';
import '../../repository/connection_repository.dart';
import '../../utils/enums.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashRepository splashRepository = SplashRepository();
  final AuthRepository authRepository = AuthRepository();
  SplashBloc() : super(SplashState()) {
    on<AppStartUp>(_validateStartUp);
  }

  void _validateStartUp(AppStartUp event , Emitter<SplashState> emit) async{

    emit(state.copyWith(splashStatus: SplashStatus.loading));
    final connectionState = await splashRepository.checkInternet();

    if (!connectionState){
      emit(state.copyWith(splashStatus: SplashStatus.error));
      return;
    }

    try{
      final validKey = await authRepository.checkKeyCache();
      if (validKey){
        emit(state.copyWith(
          splashStatus: SplashStatus.success,
            validationStatus: ValidationStatus.validated,
            message: "Validation Successful",
            isKeyStored: true,
            ));
      }
      else{
        emit(state.copyWith(
            splashStatus: SplashStatus.success,
            validationStatus: ValidationStatus.notValidated,
            message: "Validation Unsuccessful",
            isKeyStored: false));
      }
    }catch(e){
      emit(state.copyWith(
        splashStatus: SplashStatus.success,
        validationStatus: ValidationStatus.notValidated,
        message: e.toString(),
      ));
    }

  }
}
