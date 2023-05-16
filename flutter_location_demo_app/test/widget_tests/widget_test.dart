import 'package:flutter_location_demo_app/location_notifier.dart';
import 'package:flutter_location_demo_app/location_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_location_demo_app/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../unit_tests/location_notifier_test.mocks.dart';
import 'mock_location_notifier.dart';

@GenerateNiceMocks([MockSpec<Position?>()])
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    var locationNotifierMock = MockLocationNotifier();
    var mockLocationService = MockLocationService();

    var expectedPosition = Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);
    when(mockLocationService.isLocationServiceEnabled()).thenAnswer((_) => Future(() => true));
    when(mockLocationService.checkPermission()).thenAnswer((_) => Future(() => LocationPermission.always));
    when(mockLocationService.getCurrentPosition(desiredAccuracy: LocationAccuracy.high))
        .thenAnswer((_) => Future(() => expectedPosition));

    await tester.pumpWidget(ProviderScope(
      overrides: [
        locationNotifierProvider.overrideWith(() => locationNotifierMock),
        locationServiceProvider.overrideWith((ref) => mockLocationService)
      ],
      child: const MyApp(),
    ));

    expect(find.text('Update Location'), findsOneWidget);

    await tester.tap(find.text('Update Location'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Location: Lat - ${expectedPosition.latitude}, Long - ${expectedPosition.longitude}'),
        findsOneWidget);
  });
}
