import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repository/weather_repository.dart';
import '../../utils/enums.dart';
import '../model/weather_forcast_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvents, WeatherStates> {
  final WeatherRepository weatherrepository = WeatherRepository();
  WeatherBloc() : super(WeatherStates()) {
    on <CityChanged>(_cityChanged);
    on <SearchData>(_dataCollection);
    on <NavigationTap>(_navigation);
  }

  void _cityChanged(CityChanged event , Emitter <WeatherStates> emit){
    emit(
      state.copyWith(
        cityName: event.city,
      ),
    );


  }
  void _dataCollection(SearchData event, Emitter<WeatherStates> emit) async{

    emit(
      state.copyWith(
        weatherStatus: WeatherStatus.loading,
        message: "Fetching Data....",
      ),
    );

    try{
      final dataForcast = await weatherrepository.fetchForcast(state.cityName);
      emit(
        state.copyWith(
          cityName: state.cityName,
          //weatherCurrentData: [dataCurrent],
          weatherForcastData: [dataForcast],
          weatherStatus: WeatherStatus.success,
          message: "Success",
          isSearched: true,
        ),
      );
    }catch (e){
      emit(
        state.copyWith(
          weatherStatus: WeatherStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  void _navigation(NavigationTap event , Emitter<WeatherStates> emit){
    emit(state.copyWith(tapIndex: event.index));

  }
}
