import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackerv2/bloc/bloc.dart';
import 'package:screen/screen.dart';

class ProximityScreen extends StatefulWidget {
  static const String ID = 'PROXIMITY_SCREEN';

  @override
  _ProximityScreenState createState() => _ProximityScreenState();
}

class _ProximityScreenState extends State<ProximityScreen> {
  @override
  initState() {
    super.initState();
    Screen.keepOn(true);
  }

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

  @override
  void dispose() {
    Screen.keepOn(true);
    super.dispose();
  }
}
