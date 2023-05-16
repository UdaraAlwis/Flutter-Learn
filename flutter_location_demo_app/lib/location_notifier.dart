import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final locationProvider =
    AsyncNotifierProvider<LocationNotifier, void>(LocationNotifier.new);

class LocationNotifier extends AsyncNotifier<Position?> {
  Future<void> getCurrentLocation() async {
    try {
      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      state = AsyncData(currentPosition);
    } catch (e) {
      state = AsyncError('Failed to get location: $e', StackTrace.current);
    }
  }

  @override
  FutureOr<Position?> build() {
    return null;
  }
}
