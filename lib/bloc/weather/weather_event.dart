part of 'weather_bloc.dart';


abstract class WeatherEvents extends Equatable{
  const WeatherEvents();

  @override
  List<Object> get props =>[];
}

class CityChanged extends WeatherEvents{

  final String city;
  const CityChanged({ required this.city});
  @override
  List<Object> get props =>[city];

}

class SearchData extends WeatherEvents {}

class NavigationTap extends WeatherEvents{
  final int index;
  const NavigationTap({required this.index});
  @override
  List<Object> get props =>[index];

}
