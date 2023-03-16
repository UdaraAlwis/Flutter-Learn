import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled. Please enable the services');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _checkLocationPermission();
    if (hasPermission) {
      try {
        Position location = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.lowest);
        latitude = location.latitude;
        longitude = location.longitude;
      } catch (e) {
        print(e);
      }
    }
  }
}
