import 'package:WeatherApp/bloc/weather/authentication_bloc.dart';
import 'package:WeatherApp/ui/weather/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/enums.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late AuthenticationBloc _authenticationBloc;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _authenticationBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authenticationBloc,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
            listenWhen: (previous, current) {
              return  current.message.isNotEmpty;
            },
          listener: (context, state) {
            if (state.validationStatus == ValidationStatus.validated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.message}'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.green[100],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
                context.read<AuthenticationBloc>().add(clearMessage());
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (_) => const WeatherScreen()),);
              });
            }
            else if (state.validationStatus == ValidationStatus.notValidated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.message}'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red[100],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
                context.read<AuthenticationBloc>().add(clearMessage());
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Access Required",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Please enter your private API key to continue.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 50),
                Image.asset(
                  'assets/icons/weather.png',
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 12),
                Text(
                  "Weatherly",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.amberAccent,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return TextFormField(
                    controller: _textController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {

                      }
                      return null;
                    },
                  onChanged: (value){
                    context.read<AuthenticationBloc>().add(keyChange(apiKeyFetch: value));
                  },
                    onFieldSubmitted: (value){
                      context.read<AuthenticationBloc>().add(keyChange(apiKeyFetch: value));
                    },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter API Key",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey.shade900,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                  ),
                );
  },
),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                           context.read<AuthenticationBloc>().add(keyAuthentication());
                           FocusScope.of(context).unfocus();
                          _textController.clear();
                        },
                        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                            if(state.validationStatus == ValidationStatus.validating){
                              return CircularProgressIndicator();
                            }
                            return Text("Validate", style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),);
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );;
  }
}
