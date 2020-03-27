import 'package:equatable/equatable.dart';
import 'package:trackerv2/models/models.dart';

abstract class PointState extends Equatable {
  const PointState();
  @override
  List<Object> get props => [];
}

class EmptyPointList extends PointState {}

class PointTrackingInProgress extends PointState {
  final List<GraphPoint> points;

  const PointTrackingInProgress({this.points});
  @override
  List<Object> get props => [points];
}
