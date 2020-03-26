import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trackerv2/services/locationService.dart';
import './bloc.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService;
  StreamSubscription<Position> _positionSubscription;

  LocationBloc({@required LocationService locationService})
      : assert(locationService != null),
        _locationService = locationService;

  @override
  LocationState get initialState => LocationEmpty();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    final currentState = state;
    if (event is TrackingStarted) {
      yield* _mapStartToState(event);
    }
    if (event is LocationAdded) {
      yield* _mapTrackingToState(currentState, event);
    }
    if (event is Reset) {
      yield* _mapResetToState();
    }
  }

  Stream<LocationState> _mapResetToState() async* {
    _positionSubscription?.cancel();
    yield LocationTrackingInProgress(positions: []);
    yield LocationEmpty();
  }

  Stream<LocationState> _mapTrackingToState(
      LocationState currentState, LocationAdded event) async* {
    if (currentState is LocationEmpty) {
      yield LocationTrackingInProgress(positions: [event.position]);
    }
    if (currentState is LocationTrackingInProgress) {
      yield LocationTrackingInProgress(
          positions: currentState.positions + [event.position]);
    }
  }

  Stream<LocationState> _mapStartToState(
      TrackingStarted trackingStarted) async* {
    _positionSubscription?.cancel();
    _positionSubscription =
        _locationService.getPositionStream().listen((Position position) {
      if (position != null) {
        add(LocationAdded(position: position));
      }
    });
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}
