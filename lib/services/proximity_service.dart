import 'package:proximity_plugin/proximity_plugin.dart';

class ProximityService {
  Stream<ProximityEvent> getProximityData() {
    return proximityEvents;
  }
}
