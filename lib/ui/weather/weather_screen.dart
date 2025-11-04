import 'package:WeatherApp/ui/weather/settings_screen.dart';
import 'package:WeatherApp/ui/weather/weather_homepage.dart';
import 'package:WeatherApp/ui/weather/weekly_screen.dart';
import'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bloc/weather/settings_bloc.dart';
import '../../bloc/weather/weather_bloc.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late WeatherBloc _weatherBloc;
  late SettingsBloc _settingsBloc;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc();
    _settingsBloc = SettingsBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _weatherBloc.close();
    _settingsBloc.close();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: _weatherBloc,
          ),
          BlocProvider.value(
            value: _settingsBloc,
          ),
        ],
        child: BlocBuilder<WeatherBloc, WeatherStates>(
          builder: (context, state) {
            return Scaffold(
              body: IndexedStack(
                index: state.tapIndex,
                children: [
                  WeatherHomePage(focusNode: _focusNode,),
                  WeeklyScreen(),
                  SettingsScreen(),
                ],
              ),
              bottomNavigationBar:
              BlocBuilder<WeatherBloc, WeatherStates>(
                builder: (context, state) {
                  if (state.isSearched) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                        border: const Border(
                          top: BorderSide(color: Colors.white24, width: 0.5),
                        ),
                      ),
                      child: BottomNavigationBar(
                        onTap: (value) {
                          context.read<WeatherBloc>().add(
                              NavigationTap(index: value));
                        },
                        currentIndex: state.tapIndex,
                        backgroundColor: Colors.transparent,
                        selectedItemColor: Colors.white,
                        unselectedItemColor: Colors.white70,
                        type: BottomNavigationBarType.fixed,
                        selectedLabelStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        unselectedLabelStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,),
                        elevation: 0,
                        items: const [
                          BottomNavigationBarItem(icon: Icon(Icons.home),
                            label: "Home",),
                          BottomNavigationBarItem(icon: Icon(Icons.book),
                            label: "Weekly",),
                          BottomNavigationBarItem(icon: Icon(Icons.settings),
                            label: "Settings",),
                        ],
                      ),
                    );
                  }
                  return SizedBox();
                },

              ),
              floatingActionButton: BlocBuilder<WeatherBloc, WeatherStates>(
                builder: (context, state) {
                  if (state.isSearched && state.tapIndex == 0) {
                    return FloatingActionButton(
                      backgroundColor: Colors.deepPurpleAccent[100],
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => WeatherScreen()));
                      },
                      child: Icon(Icons.search),
                    );
                  }
                  return SizedBox();
                },
              ),
            );
          },
        ),
      ),

    );
  }
}
