import 'package:WeatherApp/ui/weather/splashpage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../bloc/weather/settings_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Text("Settings",
              style: GoogleFonts.poppins(
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
          SizedBox(height: 30,),
            Row(
              children: [
                Icon(WeatherIcons.thermometer),
                Text(" Temperature Unit :",
                style:GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10,),

                BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return DropdownMenu(
                    width: 130,
                    dropdownMenuEntries: [
                    DropdownMenuEntry<SettingsState>(value: SettingsState(id: '1',label:'\u00B0C'), label: 'Celsius'),
                      DropdownMenuEntry<SettingsState>(value: SettingsState(id: '2',label:'\u00B0F'), label: 'Fahrenheit'),
                    ],
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: Colors.lightBlueAccent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      )
                    ) ,
                    menuStyle: MenuStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.lightBlueAccent.shade700),
                      shadowColor: WidgetStateProperty.all(Colors.black54),
                      elevation: WidgetStateProperty.all(6),
                    ),

                    initialSelection: SettingsState(id: '1',label:'\u00B0C' ) ,
                    hintText: "Select an item",
                    enableFilter: true,
                    onSelected: (value) {
                      context.read<SettingsBloc>().add(DropDownTap(id: value!.id,label: value.label));
                    }
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 150,),
            BlocListener<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if(!state.sessionActive){
                  Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (_) => const SplashScreen()), (route) => false,
                  );
                }
              },
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: (){
                context.read<SettingsBloc>().add(LogOutTap());
              },
                  child: Text("Logout")),
            ),
          ],
        ),
      ),
    );
  }
}
