part of 'weather_bloc.dart';

class WeatherStates extends Equatable{

  final String cityName;
  final List<ForcastModel> weatherForcastData;
  final WeatherStatus weatherStatus;
  final  String message;
  final  bool isSearched;
  final int tapIndex;
  final int weeklyIndex;
  final String weeklyDate;

   const WeatherStates({
    this.cityName = '',
    this.weatherForcastData = const[],
    this.weatherStatus = WeatherStatus.initial,
    this.message = 'Please Enter A City Name to Search',
    this.isSearched = false,
    this.tapIndex = 0,
     this.weeklyIndex = 0,
     this.weeklyDate = '',
});

  WeatherStates copyWith({String? cityName ,List<ForcastModel>? weatherForcastData,WeatherStatus? weatherStatus,String? message , bool? isSearched, int? tapIndex,int? weeklyIndex,String? weeklyDate}){
    return WeatherStates(
      cityName: cityName ?? this.cityName,
      weatherForcastData: weatherForcastData ?? this.weatherForcastData,
      weatherStatus: weatherStatus ?? this.weatherStatus,
      message: message ?? this.message,
      isSearched: isSearched ?? this.isSearched,
      tapIndex: tapIndex ?? this.tapIndex,
      weeklyIndex: weeklyIndex ?? this.weeklyIndex,
      weeklyDate: weeklyDate ?? this.weeklyDate
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [cityName,weatherForcastData,weatherStatus,message,isSearched,tapIndex,weeklyIndex,weeklyDate];


}
