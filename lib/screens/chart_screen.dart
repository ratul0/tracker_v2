import 'package:flutter/material.dart';
import 'package:trackerv2/widgets/line_drawing_widget.dart';
import 'package:trackerv2/widgets/widgets.dart';

class ChartScreen extends StatelessWidget {
  static const String ID = 'CHART_SCREEN';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Path Drawing'),
        ),
        body: Stack(
          children: <Widget>[
            LineDrawingWidget(),
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
        ));
  }
}
