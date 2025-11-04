import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/connection_repository.dart';
import '../../utils/enums.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashRepository splashRepository = SplashRepository();
  SplashBloc() : super(SplashState()) {
    on<SplashTrigger>(_checkState);
  }


  Future <void> _checkState(SplashTrigger event , Emitter<SplashState> emit) async {

    emit(state.copyWith(splashStatus: SplashStatus.loading));
    final connectionState = await splashRepository.checkInternet();

    if (!connectionState){
      emit(state.copyWith(splashStatus: SplashStatus.error));
    }
    else{
      emit(state.copyWith(splashStatus: SplashStatus.success));
    }






  }
}
