import 'package:WeatherApp/bloc/weather/weather_bloc.dart';
import 'package:WeatherApp/utils/dateconvert.dart';
import 'package:WeatherApp/utils/enums.dart';
import 'package:WeatherApp/widgets/weather/textinfo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons/weather_icons.dart';

class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: BlocBuilder<WeatherBloc, WeatherStates>(
            builder: (context, state) {
              if(state.weatherStatus!=WeatherStatus.success){
                return SizedBox();
              }
              else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Center(
                          child: TextInfo(
                            value: "Weekly Updates",
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                          )
                      ),

                      SizedBox(height: 30,),

                      BlocBuilder<WeatherBloc, WeatherStates>(
                        builder: (context, state) {
                          final location = state.weatherForcastData[0].location;
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 32,
                                  ),
                                  SizedBox(width: 1,),
                                  TextInfo(
                                    value: "${location?.name}",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25,
                                  ),
                                ],
                              ),
                              TextInfo(
                                value: "${location?.country}",
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ],
                          );
                        },
                      ),

                      // SizedBox(height: 10,),
                      // BlocBuilder<WeatherBloc, WeatherStates>(
                      //   builder: (context, state) {
                      //     return TextInfo(
                      //       value: "${state.weeklyDate}",
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 20,
                      //     );
                      //   },
                      // ),

                      SizedBox(height: 20,),

                      BlocBuilder<WeatherBloc, WeatherStates>(
                        builder: (context, state) {
                          final weatherData = state.weatherForcastData[0].forecast?.forecastday;
                          final daysCount = weatherData?.length;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: List.generate(
                                  daysCount!, (index) {
                                  final dateInfo = weatherData?[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: Colors.white.withOpacity(
                                            0.3),
                                        highlightColor: Colors.white24,
                                        onTap: () async {
                                          context.read<WeatherBloc>().add(
                                              WeeklyTap(
                                                  indexTap: index,
                                                  date: "${dateInfo!.date}")
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.orangeAccent[200],
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: TextInfo(
                                            value: "${dateInfo?.date}",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      Expanded(
                        child: BlocBuilder<WeatherBloc, WeatherStates>(
                          builder: (context, state) {
                            final weatherData = state.weatherForcastData[0]
                                .forecast?.forecastday;
                            final indexSelected = state.weeklyIndex;
                            final dayData = weatherData?[indexSelected].day;
                            final astroData = weatherData?[indexSelected].astro;
                            final dayName = getDayName('${weatherData![indexSelected].date}');
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                      TextInfo(
                                      value: "${weatherData[indexSelected].date}",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                          Text(
                                            "$dayName",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                color: Colors.amber),
                                          ),
                                          const SizedBox(height: 30),

                                          const TextInfo(
                                            value: "Day Forcast",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                          ),
                                          const SizedBox(height: 20),
                                          TextInfo(
                                              value: 'Condition: ${dayData?.condition?.text}',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19),
                                          Image.network(dayData!.condition!.icon!.startsWith('//') ?
                                          'https:${dayData.condition!.icon}'
                                              :dayData.condition!.icon.toString(),
                                            scale: 0.39,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.thermometer),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'Max Temp: ${dayData.maxtempC}\u00B0C',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.thermometer),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'Min Temp: ${dayData.mintempC}\u00B0C',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.thermometer),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'Avg Temp: ${dayData.avgtempC}\u00B0C',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.wind_beaufort_0),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'Max Wind: ${dayData.maxwindKph} kph',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.humidity),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'Total Precipitation: ${dayData.totalprecipMm} mm',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.day_sunny),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'UV Index: ${dayData.uv}',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.rain),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'Chance of Rain: ${dayData.dailyWillItRain} kph',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),

                                          const SizedBox(height: 40),

                                          TextInfo(
                                            value: "Astronomical Info",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.sunrise),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'Sunrise: ${astroData?.sunrise}',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.sunset),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'Sunset: ${astroData?.sunset}',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.moonrise),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'Moonrise: ${astroData?.moonrise}',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.moonset),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'Moonrise: ${astroData?.moonset}',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(WeatherIcons.moonrise),
                                              SizedBox(width: 15,),
                                              TextInfo(
                                                value:'Moonphase: ${astroData?.moonPhase}',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15,),
                                          const Divider(
                                              thickness: 1, color: Colors.grey),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ]
                );
              }
      },
    ),
        ),
       );
  }
}
