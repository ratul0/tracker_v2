import 'package:geolocator/geolocator.dart';

class LocationService {
  final Geolocator _geoLocator = Geolocator();
  final LocationOptions _locationOptions = LocationOptions(
    accuracy: LocationAccuracy.best,
    distanceFilter: 0,
  );
  Stream<Position> getPositionStream() {
    return _geoLocator.getPositionStream(_locationOptions);
  }
}
