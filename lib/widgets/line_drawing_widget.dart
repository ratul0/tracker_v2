import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackerv2/bloc/bloc.dart';
import 'package:trackerv2/models/models.dart';

class LineDrawingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointBloc, PointState>(
      // ignore: missing_return
      builder: (context, locationState) {
        if (locationState is PointTrackingInProgress) {
          return Container(
            child: charts.LineChart(
              [
                charts.Series<GraphPoint, double>(
                  id: 'Movements',
                  colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                  domainFn: (GraphPoint p, _) => p.long,
                  measureFn: (GraphPoint p, _) => p.lat,
                  data: locationState.points,
                ),
              ].cast<charts.Series<GraphPoint, double>>(),
              animate: false,
              defaultRenderer:
                  new charts.LineRendererConfig(includePoints: true),
            ),
          );
        }
        if (locationState is EmptyPointList) {
          return Container(
            child: Center(
              child: Text('Press Play button to start..'),
            ),
          );
        }
      },
    );
  }
}
