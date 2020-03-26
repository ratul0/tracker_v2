import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trackerv2/bloc/bloc.dart';

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
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 8,
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
              Expanded(
                flex: 2,
                child: _showButtons(context, locationBloc),
              )
            ],
          ),
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

  Widget _showButtons(BuildContext context, LocationBloc locationBloc) {
    return BlocBuilder<LocationBloc, LocationState>(
      condition: (previousState, state) =>
          state.runtimeType != previousState.runtimeType,
      // ignore: missing_return
      builder: (context, locationState) {
        if (locationState is LocationEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: const CircleBorder(side: BorderSide.none),
                onPressed: () => locationBloc.add(
                  TrackingStarted(),
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.green.shade900,
                ),
              ),
            ],
          );
        }
        if (locationState is LocationTrackingInProgress) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: const CircleBorder(side: BorderSide.none),
                onPressed: () => locationBloc.add(
                  Reset(),
                ),
                child: Icon(
                  Icons.restore,
                  color: Colors.purple.shade900,
                ),
              ),
              RaisedButton(
                shape: const CircleBorder(side: BorderSide.none),
                onPressed: () => locationBloc.add(
                  Paused(),
                ),
                child: Icon(
                  Icons.pause,
                  color: Colors.yellow.shade900,
                ),
              ),
            ],
          );
        }
        if (locationState is LocationTrackingPaused) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: const CircleBorder(side: BorderSide.none),
                onPressed: () => locationBloc.add(
                  Reset(),
                ),
                child: Icon(
                  Icons.restore,
                  color: Colors.purple.shade900,
                ),
              ),
              RaisedButton(
                shape: const CircleBorder(side: BorderSide.none),
                onPressed: () => locationBloc.add(
                  Resumed(),
                ),
                child: Icon(
                  Icons.fast_forward,
                  color: Colors.lightGreen,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
