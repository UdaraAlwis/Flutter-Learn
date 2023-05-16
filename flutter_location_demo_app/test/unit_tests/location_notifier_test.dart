import 'package:flutter_location_demo_app/location_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'location_notifier_test.mocks.dart';

@GenerateMocks([Geolocator])
void main() {
  late MockGeolocator mockGeolocator;
  late ProviderContainer container;

  setUp(() {
    mockGeolocator = MockGeolocator();
    container = ProviderContainer();
    container.read(locationProvider).overrideWithValue(mockGeolocator);
  });

  tearDown(() {
    container.dispose();
  });

  test('LocationNotifier - getCurrentLocation success', () async {
    final position = Position(latitude: 37.4219983, longitude: -122.084);
    when(mockGeolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high))
        .thenAnswer((_) async => position);

    final notifier = container.read(locationProvider.notifier);

    await notifier.getCurrentLocation();

    expect(notifier.state, AsyncData(position));
  });

  test('LocationNotifier - getCurrentLocation error', () async {
    final error = 'Failed to get location';
    when(mockGeolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high))
        .thenThrow(error);

    final notifier = container.read(locationProvider.notifier);

    await notifier.getCurrentLocation();

    expect(notifier.state, AsyncError(error, any));
  });
}
