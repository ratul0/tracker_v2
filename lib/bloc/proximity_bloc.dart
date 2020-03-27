import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:proximity_plugin/proximity_plugin.dart';
import 'package:trackerv2/services/services.dart';
import './bloc.dart';

class ProximityBloc extends Bloc<LocalProximityEvent, ProximityState> {
  StreamSubscription proximitySubscription;
  final ProximityService proximityService;

  ProximityBloc(this.proximityService) {
    proximitySubscription =
        proximityService.getProximityData().listen((ProximityEvent event) {
      event.x == 'Yes' ? add(ObjectDetected()) : add(ObjectGone());
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
