import 'package:all_sensors/all_sensors.dart';

class ProximityService {
  Stream<ProximityEvent> getProximityData() {
    return proximityEvents;
  }
}
