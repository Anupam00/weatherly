import 'package:WeatherApp/repository/auth_repository.dart';
import 'package:WeatherApp/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final AuthRepository authRepository = AuthRepository();
  AuthenticationBloc() : super(AuthenticationState()) {
    on<keyChange>(_getFullKey);
    on<keyAuthentication>(_validateKey);
    on<clearMessage>(_disposeMessage);
  }


  void _getFullKey(keyChange event , Emitter<AuthenticationState> emit){
    emit(state.copyWith(apikey: event.apiKeyFetch));
  }

  void _validateKey(keyAuthentication event , Emitter<AuthenticationState> emit) async{

    emit(state.copyWith(validationStatus: ValidationStatus.validating));
    try{
      final validInputKey = await authRepository.checkKey(state.apikey);
      if(validInputKey){
        emit(state.copyWith(
          validationStatus: ValidationStatus.validated,
          message: "Validation Successful",
        ));
      }else{
        emit(state.copyWith(
            validationStatus: ValidationStatus.notValidated,
        ));
      }
    }catch(e){
      emit(state.copyWith(
          validationStatus: ValidationStatus.notValidated,
          message: e.toString(),
      ));
      }
  }

  void _disposeMessage(clearMessage event , Emitter<AuthenticationState> emit){
    emit(state.copyWith(message: ''));
  }

}
