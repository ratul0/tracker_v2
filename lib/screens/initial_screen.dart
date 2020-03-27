import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trackerv2/bloc/bloc.dart';
import 'package:trackerv2/screens/screens.dart';
import 'package:trackerv2/widgets/widgets.dart';

class InitialScreen extends StatelessWidget {
  static const String ID = 'INITIAL';
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Your Location'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.timeline),
            onPressed: () {
              Navigator.pushNamed(context, ChartScreen.ID);
            },
          ),
          IconButton(
            icon: Icon(Icons.pan_tool),
            onPressed: () {
              Navigator.pushNamed(context, ProximityScreen.ID);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              child: BlocBuilder<LocationBloc, LocationState>(
                // ignore: missing_return
                builder: (context, locationState) {
                  if (locationState is LocationEmpty) {
                    return buildCenter();
                  }
                  if (locationState is LocationTrackingInProgress) {
                    return ListView.builder(
                      itemCount: locationState.positions?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LocationListCard(
                          position: locationState.positions[index],
                        );
                      },
                    );
                  }
                  if (locationState is LocationTrackingPaused) {
                    return ListView.builder(
                      itemCount: locationState.positions?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LocationListCard(
                          position: locationState.positions[index],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ActionWidget(),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Center buildCenter() {
    return Center(
      child: TypewriterAnimatedTextKit(
        text: ['Press Play Button To Start Tracking..'],
        textStyle: TextStyle(
          fontSize: 18.0,
        ),
        totalRepeatCount: 1000,
        speed: Duration(milliseconds: 150),
      ),
    );
  }
}
