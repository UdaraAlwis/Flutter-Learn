import 'dart:async';

import 'package:flutter_location_demo_app/location_notifier.dart';
import 'package:flutter_location_demo_app/location_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';

// As of now I'm duplicating the entire LocationNotifier
// in this mock class to get it to work
// If not I get this weird error on test run
// _TypeError (type 'Null' is not a subtype of type 'Future<void>')
// Shouldn't there be a better way?
class MockLocationNotifier extends AsyncNotifier<Position?> with Mock implements LocationNotifier {
  @override
  Future<void> getCurrentLocation() async {
    var locationService = ref.watch(locationServiceProvider);

    state = const AsyncValue.loading();

    var isLocationServicesEnabled = await locationService.isLocationServiceEnabled();
    if (!isLocationServicesEnabled) {
      state = AsyncValue.error('Location services are disabled!', StackTrace.current);
      return;
    }

    var currentPermission = await locationService.checkPermission();
    if (currentPermission == LocationPermission.denied) {
      var permission = await locationService.requestPermission();
      if (permission == LocationPermission.denied) {
        state = AsyncValue.error('Location permissions are denied!', StackTrace.current);
        return;
      }
    } else if (currentPermission == LocationPermission.deniedForever) {
      state = AsyncValue.error('Location permissions are denied forever!', StackTrace.current);
      return;
    }

    try {
      final currentPosition = await locationService.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      state = AsyncValue.data(currentPosition);
    } catch (e) {
      state = AsyncValue.error('Failed to get location: $e', StackTrace.current);
      return;
    }
  }

  @override
  FutureOr<Position?> build() {
    getCurrentLocation();
    return null;
  }
}
