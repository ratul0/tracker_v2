import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trackerv2/bloc/bloc.dart';
import 'package:trackerv2/widgets/actions_widget.dart';

class InitialScreen extends StatelessWidget {
  static const String ID = 'INITIAL';
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Your Location'),
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
                        return _locationCard(locationState.positions[index]);
                      },
                    );
                  }
                  if (locationState is LocationTrackingPaused) {
                    return ListView.builder(
                      itemCount: locationState.positions?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _locationCard(locationState.positions[index]);
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
          fontSize: 20.0,
        ),
        totalRepeatCount: 1000,
        speed: Duration(milliseconds: 150),
      ),
    );
  }

  Widget _locationCard(Position position) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Lattitude: ${position.latitude}',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Longitude: ${position.longitude}',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '${position.timestamp.toIso8601String()}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ));
  }
}
