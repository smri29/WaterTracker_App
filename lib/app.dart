import 'package:flutter/material.dart';
import 'package:watertracker/home_screen.dart';
import 'package:watertracker/water_track.dart';


class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
