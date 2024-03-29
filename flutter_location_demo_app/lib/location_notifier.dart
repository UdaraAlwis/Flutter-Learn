import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'location_service_provider.dart';

final locationNotifierProvider = AsyncNotifierProvider<LocationNotifier, Position?>(LocationNotifier.new);

class LocationNotifier extends AsyncNotifier<Position?> {
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
