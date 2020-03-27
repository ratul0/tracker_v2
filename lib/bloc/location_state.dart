import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trackerv2/models/graph_point_model.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object> get props => [];
}

class LocationEmpty extends LocationState {}

class LocationTrackingInProgress extends LocationState {
  final List<Position> positions;

  const LocationTrackingInProgress({this.positions});

  @override
  List<Object> get props => [positions];
}

class LocationTrackingPaused extends LocationState {
  final List<Position> positions;

  const LocationTrackingPaused({this.positions});

  @override
  List<Object> get props => [positions];
}
