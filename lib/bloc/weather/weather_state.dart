part of 'weather_bloc.dart';

class WeatherStates extends Equatable{

  final String cityName;
  //final List<WeatherModel> weatherCurrentData;
  final List<ForcastModel> weatherForcastData;
  final WeatherStatus weatherStatus;
  final  String message;
  final  bool isSearched;
  final int tapIndex;

   const WeatherStates({
    this.cityName = '',
    //this.weatherCurrentData = const[],
    this.weatherForcastData = const[],
    this.weatherStatus = WeatherStatus.initial,
    this.message = 'Please Enter A City Name to Search',
    this.isSearched = false,
    this.tapIndex = 0,
});

  WeatherStates copyWith({String? cityName ,List<ForcastModel>? weatherForcastData,WeatherStatus? weatherStatus,String? message , bool? isSearched, int? tapIndex}){
    return WeatherStates(
      cityName: cityName ?? this.cityName,
      //weatherCurrentData: weatherCurrentData ?? this.weatherCurrentData,
      weatherForcastData: weatherForcastData ?? this.weatherForcastData,
      weatherStatus: weatherStatus ?? this.weatherStatus,
      message: message ?? this.message,
      isSearched: isSearched ?? this.isSearched,
      tapIndex: tapIndex ?? this.tapIndex,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [cityName,weatherForcastData,weatherStatus,message,isSearched,tapIndex];


}
