import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
  @override
  List<Object> get props => [];
}

class TrackingStarted extends LocationEvent {}

class LocationAdded extends LocationEvent {
  final Position position;
  const LocationAdded({@required this.position}) : assert(position != null);

  @override
  List<Object> get props => [position];
}

class Reset extends LocationEvent {}
