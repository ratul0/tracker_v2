import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackerv2/bloc/bloc.dart';
import 'package:trackerv2/screens/chart_screen.dart';
import 'package:trackerv2/screens/screens.dart';
import 'package:trackerv2/services/locationService.dart';
import 'package:trackerv2/simple_bloc_delegate.dart';

void main() {
  //BlocSupervisor.delegate = SimpleBlocDelegate();
  final LocationService locationService = LocationService();
  final LocationBloc locationBloc =
      LocationBloc(locationService: locationService);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (context) => locationBloc,
        ),
        BlocProvider<PointBloc>(
          create: (context) => PointBloc(locationBloc),
        )
      ],
      child: LocationTrackerApp(),
    ),
  );
}

class LocationTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Location Tracker",
        initialRoute: InitialScreen.ID,
        routes: {
          InitialScreen.ID: (_) => InitialScreen(),
          ChartScreen.ID: (_) => ChartScreen(),
        });
  }
}
