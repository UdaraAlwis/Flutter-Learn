// Mocks generated by Mockito 5.4.0 from annotations
// in flutter_location_demo_app/test/unit_tests/location_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_location_demo_app/location_service_provider.dart'
    as _i3;
import 'package:geolocator/geolocator.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePosition_0 extends _i1.SmartFake implements _i2.Position {
  _FakePosition_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LocationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocationService extends _i1.Mock implements _i3.LocationService {
  @override
  _i4.Future<_i2.LocationPermission> checkPermission() => (super.noSuchMethod(
        Invocation.method(
          #checkPermission,
          [],
        ),
        returnValue: _i4.Future<_i2.LocationPermission>.value(
            _i2.LocationPermission.denied),
        returnValueForMissingStub: _i4.Future<_i2.LocationPermission>.value(
            _i2.LocationPermission.denied),
      ) as _i4.Future<_i2.LocationPermission>);
  @override
  _i4.Future<bool> isLocationServiceEnabled() => (super.noSuchMethod(
        Invocation.method(
          #isLocationServiceEnabled,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<_i2.LocationPermission> requestPermission() => (super.noSuchMethod(
        Invocation.method(
          #requestPermission,
          [],
        ),
        returnValue: _i4.Future<_i2.LocationPermission>.value(
            _i2.LocationPermission.denied),
        returnValueForMissingStub: _i4.Future<_i2.LocationPermission>.value(
            _i2.LocationPermission.denied),
      ) as _i4.Future<_i2.LocationPermission>);
  @override
  _i4.Future<_i2.Position> getCurrentPosition({
    _i2.LocationAccuracy? desiredAccuracy = _i2.LocationAccuracy.best,
    bool? forceAndroidLocationManager = false,
    Duration? timeLimit,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentPosition,
          [],
          {
            #desiredAccuracy: desiredAccuracy,
            #forceAndroidLocationManager: forceAndroidLocationManager,
            #timeLimit: timeLimit,
          },
        ),
        returnValue: _i4.Future<_i2.Position>.value(_FakePosition_0(
          this,
          Invocation.method(
            #getCurrentPosition,
            [],
            {
              #desiredAccuracy: desiredAccuracy,
              #forceAndroidLocationManager: forceAndroidLocationManager,
              #timeLimit: timeLimit,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Position>.value(_FakePosition_0(
          this,
          Invocation.method(
            #getCurrentPosition,
            [],
            {
              #desiredAccuracy: desiredAccuracy,
              #forceAndroidLocationManager: forceAndroidLocationManager,
              #timeLimit: timeLimit,
            },
          ),
        )),
      ) as _i4.Future<_i2.Position>);
}
