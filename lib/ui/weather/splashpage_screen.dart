import "package:WeatherApp/bloc/weather/authentication_bloc.dart";
import "package:WeatherApp/ui/weather/authentication_screen.dart";
import "package:WeatherApp/ui/weather/weather_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../bloc/weather/splash_bloc.dart";
import "../../utils/enums.dart";


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashBloc _splashBloc;

  @override
  void initState() {
    super.initState();
    _splashBloc = SplashBloc();
    _splashBloc.add(AppStartUp());
  }

  @override
  void dispose() {
    _splashBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocProvider.value(
              value: _splashBloc,
          child: Scaffold(
            body: BlocListener<SplashBloc, SplashState>(
              listener: (context, state) {
                  if(state.splashStatus == SplashStatus.success &&
                      state.isKeyStored &&
                      state.validationStatus == ValidationStatus.validated) {
                    WidgetsBinding.instance.addPostFrameCallback( (_) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (_) => const WeatherScreen()),);
                        }
                    );
                  }
                else if(state.splashStatus == SplashStatus.success &&
                      !state.isKeyStored &&
                      state.validationStatus == ValidationStatus.notValidated){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (_) => const AuthenticationScreen()),);
                        }
                else if (state.splashStatus == SplashStatus.error) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            title: const Text("No Internet Connection"),
                            content: const Text(
                                "Please check your network and try again."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _splashBloc.add(AppStartUp());
                                },
                                child: const Text("Retry"),
                              ),
                            ],
                          ),
                    );
                  });
                }
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/icons/weather.png',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Weatherly",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.amberAccent,
                      ),
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder<SplashBloc, SplashState>(
                      builder: (context, state) {
                        if (state.splashStatus == SplashStatus.loading) {
                          return Column(
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(height: 10),
                              Text("Checking Connection. Please Wait !!!"),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
