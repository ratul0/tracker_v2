import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackerv2/bloc/bloc.dart';

class ProximityScreen extends StatelessWidget {
  static const String ID = 'PROXIMITY_SCREEN';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Data'),
      ),
      body: Container(
        child: Center(
          child: BlocBuilder<ProximityBloc, ProximityState>(
            // ignore: missing_return
            builder: (context, proximityState) {
              if (proximityState is ProximityPositive) {
                return Text('Something is near to your front camera');
              }
              if (proximityState is ProximityNegative) {
                return Text('Nothing is close to your front camera');
              }
            },
          ),
        ),
      ),
    );
  }
}
