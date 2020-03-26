import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: BlocBuilder<LocationBloc, LocationState>(
                    // ignore: missing_return
                    builder: (context, locationState) {
                      if (locationState is LocationEmpty) {
                        return Text('Please start Tracking');
                      }
                      if (locationState is LocationTrackingInProgress) {
                        return ListView.builder(
                          itemCount: locationState.positions?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                  'lat ${locationState.positions[index].latitude}'),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => locationBloc.add(
                          TrackingStarted(),
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.green.shade900,
                        ),
                      ),
                      RaisedButton(
                        onPressed: () => locationBloc.add(
                          Reset(),
                        ),
                        child: Icon(
                          Icons.pause,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
