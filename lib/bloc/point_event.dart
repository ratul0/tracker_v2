import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class PointEvent extends Equatable {
  const PointEvent();
  @override
  List<Object> get props => [];
}

class PointListInitialized extends PointEvent {}

class LocationProcessedForPoints extends PointEvent {
  final List<Position> positions;

  LocationProcessedForPoints(this.positions);
  @override
  List<Object> get props => [positions];
}
