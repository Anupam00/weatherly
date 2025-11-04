import 'package:flutter/material.dart';

class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  @override
  Widget build(BuildContext context) {
    return   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("This is Weekly Updates"),),
        ],
    );
  }
}
