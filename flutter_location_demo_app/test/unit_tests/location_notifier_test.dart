import 'package:flutter_location_demo_app/location_notifier.dart';
import 'package:flutter_location_demo_app/location_service_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'location_notifier_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocationService>()])
void main() {
  late MockLocationService mockLocationService;
  late ProviderContainer container;

  setUp(() {
    mockLocationService = MockLocationService();
    container = ProviderContainer(overrides: [locationServiceProvider.overrideWithValue(mockLocationService)]);
  });

  tearDown(() {
    container.dispose();
  });

  test('LocationNotifier - getCurrentLocation error - location services disabled', () async {
    await container.read(locationNotifierProvider.notifier).getCurrentLocation();

    expect(container.read(locationNotifierProvider).hasError, true);
    expect(container.read(locationNotifierProvider).error, 'Location services are disabled!');
  });

  test('LocationNotifier - getCurrentLocation error - location permission denied', () async {
    when(mockLocationService.isLocationServiceEnabled()).thenAnswer((realInvocation) => Future(() => true));
    await container.read(locationNotifierProvider.notifier).getCurrentLocation();

    expect(container.read(locationNotifierProvider).hasError, true);
    expect(container.read(locationNotifierProvider).error, 'Location permissions are denied!');
  });

  test('LocationNotifier - getCurrentLocation success - location data returned', () async {
    var expectedPosition = Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);

    when(mockLocationService.isLocationServiceEnabled()).thenAnswer((realInvocation) => Future(() => true));
    when(mockLocationService.checkPermission()).thenAnswer((realInvocation) => Future(() => LocationPermission.always));
    when(mockLocationService.getCurrentPosition(desiredAccuracy: LocationAccuracy.high))
        .thenAnswer((realInvocation) => Future(() => expectedPosition));
    await container.read(locationNotifierProvider.notifier).getCurrentLocation();

    expect(container.read(locationNotifierProvider).hasError, false);
    expect(container.read(locationNotifierProvider).value, expectedPosition);
  });
}
