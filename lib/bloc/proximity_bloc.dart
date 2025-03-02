import 'dart:async';
import 'package:all_sensors/all_sensors.dart';
import 'package:bloc/bloc.dart';
import 'package:trackerv2/services/services.dart';
import './bloc.dart';
import 'package:vibration/vibration.dart';

class ProximityBloc extends Bloc<LocalProximityEvent, ProximityState> {
  StreamSubscription proximitySubscription;
  final ProximityService proximityService;

  ProximityBloc(this.proximityService) {
    proximitySubscription =
        proximityService.getProximityData().listen((ProximityEvent event) {
      event.getValue() ? add(ObjectDetected()) : add(ObjectGone());
    });
  }

  @override
  ProximityState get initialState => ProximityNegative();

  @override
  Stream<ProximityState> mapEventToState(
    LocalProximityEvent event,
  ) async* {
    if (event is ObjectDetected) {
      yield ProximityPositive();
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate();
      }
    }
    if (event is ObjectGone) {
      yield ProximityNegative();
    }
  }

  @override
  Future<void> close() {
    proximitySubscription.cancel();
    return super.close();
  }
}
