import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../bloc/weather/settings_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';
import '../../utils/dateconvert.dart';
import '../../utils/enums.dart';
import '../../widgets/weather/textinfo_widget.dart';

class WeatherHomePage extends StatelessWidget {
  final FocusNode focusNode;

  const WeatherHomePage({super.key,required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: SingleChildScrollView(
          child: Column(
                  children: [
                    SizedBox(height: 60,),
                 BlocBuilder<WeatherBloc,WeatherStates>(
                  builder: (context,state) {
                  if (state.isSearched) {
                  return SizedBox();
                  }else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              WeatherIcons.day_sunny,
                              size: 90,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Welcome to Weatherly ☁️",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 30),

                            Container(
                              height: 50,
                              child: TextFormField(
                                //keyboardType: TextInputType.text,
                                //focusNode: focusNode ,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      context.read<WeatherBloc>().add(SearchData());
                                      FocusScope.of(context).unfocus();
                                    }, icon: Icon(Icons.search),
                                  ),
                                  prefixIcon: Icon(Icons.location_city_outlined),
                                  hintText: "Enter City Name",
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.2),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent, width: 2),
                                  ),
                                ),
                                onChanged: (value) {
                                  context.read<WeatherBloc>().add(
                                      CityChanged(city: value));
                                },
                                onFieldSubmitted: (value) {
                                  context.read<WeatherBloc>().add(SearchData());
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            Icon(
                              Icons.arrow_upward_rounded,
                              color: Colors.white70,
                              size: 28,
                            ),
                            Text(
                              "Search your city above",
                              style: GoogleFonts.poppins(
                                color: Colors.white60,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                    }
                    ),

                    BlocBuilder<WeatherBloc,WeatherStates>(
                        builder: (context,state) {
                          switch(state.weatherStatus){
                            case WeatherStatus.initial:
                              return SizedBox();
                            case (WeatherStatus.loading ):
                              return
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 100,),
                                        CircularProgressIndicator(),
                                        SizedBox(height: 10,),
                                        Text(state.message.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blueGrey,

                                          ) ,),
                                      ],
                                    ),
                                  ),
                                );
                            case (WeatherStatus.success):
                              final location  = state.weatherForcastData[0].location;
                              final current  = state.weatherForcastData[0].current;
                              final dayDate = state.weatherForcastData[0].forecast!.forecastday![0].date;
                              final dayName = getDayName('$dayDate');
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 112,),
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                            size: 32,
                                          ),
                                          SizedBox(width: 1,),
                                          Text(location!.name.toString(),style: GoogleFonts.poppins(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                          ),),
                                        ],
                                      ),
                                      Text(location.country.toString(),style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                      SizedBox(height: 25,),


                                      TextInfo(
                                        value: '$dayDate',
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),

                                      TextInfo(
                                        value: '$dayName',
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),

                                      Text(
                                        DateFormat('h:mm a').format(DateTime.parse(location.localtime!)),
                                        style: GoogleFonts.poppins(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                      ),),

                                      SizedBox(height: 20,),

                                      Image.network(current!.condition!.icon!.startsWith('//') ?
                                         'https:${current.condition!.icon}'
                                          :current.condition!.icon.toString(),
                                        scale: 0.39,
                                           ),
                                      BlocBuilder<SettingsBloc, SettingsState>(
                                        builder: (context, state) {
                                          if(state.label == "\u00B0C") {
                                            return Text(
                                              '${current.tempC} \u00B0C ',
                                              style: GoogleFonts.poppins(
                                                fontSize: 40,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            );
                                          }
                                          return  Text(
                                            '${current.tempF} \u00B0F ',
                                            style: GoogleFonts.poppins(
                                              fontSize: 40,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        },
                                      ),

                                      Text(current.condition!.text.toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      SizedBox(height: 30,),
                                      Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Icon(WeatherIcons.thermometer),
                                              BlocBuilder<SettingsBloc, SettingsState>(
                                                builder: (context, state) {
                                                  if(state.label == "\u00B0C") {
                                                    return TextInfo(
                                                      label: 'Feels Like',
                                                      value: '${current.feelslikeC} \u00B0C',
                                                      fontSize: 16 ,
                                                      fontWeight: FontWeight.w600,
                                                    );
                                                  }
                                                  return  TextInfo(
                                                    label: 'Feels Like',
                                                    value: '${current.feelslikeF} \u00B0F',
                                                    fontSize: 16 ,
                                                    fontWeight: FontWeight.w600,
                                                  );
                                                },
                                              ),
                                              SizedBox(height: 10,),
                                              Icon(WeatherIcons.barometer),
                                              Text(
                                                'Pressure: ${current.pressureIn} ',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(width: 50,),
                                              Icon(WeatherIcons.humidity),
                                              Text(
                                                'Humidity: ${current.humidity} ',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Icon(Icons.remove_red_eye),
                                              TextInfo(
                                                  label: 'Visibility',
                                                  value: '${current.visKm}',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 30,),
                                      Text(
                                        'Hourly Updates ',
                                        style: GoogleFonts.poppins(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      SizedBox(
                                        height: 210,
                                        child: ListView.builder(
                                            itemCount: state.weatherForcastData[0].forecast
                                                ?.forecastday?[0].hour?.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final item = state.weatherForcastData[0].forecast
                                                  ?.forecastday?[0].hour?[index];
                                              return  Column(
                                                children: [
                                                  SizedBox(
                                                   width : 200,
                                                    child: Card(
                                                      color:Colors.lightBlueAccent[200],
                                                      shadowColor: Colors.blueGrey,
                                                      elevation: 5,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                            DateFormat('h:mm a').format(DateTime.parse(item!.time!)),
                                                              style: GoogleFonts.poppins(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w800,
                                                              ),
                                                            ),
                                                            SizedBox(height: 5,),
                                                            ClipRRect(
                                                              borderRadius: BorderRadius.circular(5),
                                                              clipBehavior: Clip.antiAlias,
                                                              child: Image.network(item!.condition!.icon!.startsWith('//') ?
                                                              'https:${item.condition!.icon}'
                                                                  :item.condition!.icon.toString(),
                                                                scale: 0.8,
                                                              ),
                                                            ),
                                                            BlocBuilder<SettingsBloc, SettingsState>(
                                                              builder: (context, state) {
                                                                if(state.label == "\u00B0C") {
                                                                  return TextInfo(
                                                                    value: '${item.tempC} \u00B0C',
                                                                    fontSize: 20 ,
                                                                    fontWeight: FontWeight.w600,
                                                                  );
                                                                }
                                                                return  TextInfo(
                                                                  value: '${item.tempF} \u00B0F',
                                                                  fontSize: 20 ,
                                                                  fontWeight: FontWeight.w600,
                                                                );
                                                              },
                                                            ),
                                                            SizedBox(height: 5,),
                                                            Text(
                                                              ' ${item.condition!.text}',
                                                              style: GoogleFonts.poppins(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            case WeatherStatus.error:
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 100,),
                                    Center(
                                      child: Text(state.message.toString(),
                                        style: GoogleFonts.poppins(
                                            color: Colors.red.shade700,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),),
                                  ],
                                ),
                              );
                          }
                        }
                    ),
                  ],
                ),
        ),
    );
  }
}
