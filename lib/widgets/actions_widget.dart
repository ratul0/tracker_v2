import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackerv2/bloc/bloc.dart';

class ActionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final locationBloc = BlocProvider.of<LocationBloc>(context);

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
                  Paused(),
                ),
                child: Icon(
                  Icons.pause,
                  color: Colors.yellow.shade900,
                ),
              ),
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
                  Resumed(),
                ),
                child: Icon(
                  Icons.fast_forward,
                  color: Colors.lightGreen,
                ),
              ),
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
            ],
          );
        }
      },
    );
  }
}
