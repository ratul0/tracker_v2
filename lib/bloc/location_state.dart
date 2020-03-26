import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

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
