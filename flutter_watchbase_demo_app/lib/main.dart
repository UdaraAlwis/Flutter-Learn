import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_watchbase_demo_app/model/watch_details.dart';
import 'package:flutter_watchbase_demo_app/pages/watchdetails_page.dart';

import 'model/brand_family.dart';
import 'model/brand.dart';
import 'model/watch.dart';
import 'pages/home_page.dart';
import 'repository/brand_repository.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Watchbase Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {WatchDetailsPage.id: (context) => const WatchDetailsPage()},
    ),
  ));
}

final brandRepositoryProvider = Provider((ref) => BrandRepository());

final brandsProvider = FutureProvider<List<Brand>>((ref) async {
  var repository = ref.watch(brandRepositoryProvider);
  return repository.getBrands();
});

final brandFamiliesProvider = FutureProvider<List<BrandFamily>>((ref) async {
  var repository = ref.watch(brandRepositoryProvider);
  var selectedBrandId = ref.watch(selectedBrandIdProvider);
  return repository.getFamilies(selectedBrandId!);
});

final watchesProvider = FutureProvider<List<Watch>>((ref) async {
  var repository = ref.watch(brandRepositoryProvider);
  var selectedBrandId = ref.watch(selectedBrandIdProvider);
  var selectedBrandFamilyId = ref.watch(selectedBrandFamilyIdProvider);
  return repository.getWatches(selectedBrandId!, selectedBrandFamilyId!);
});

final watchDetailsProvider = FutureProvider<WatchDetails>((ref) async {
  var repository = ref.watch(brandRepositoryProvider);
  var selectedWatchId = ref.watch(selectedWatchIdProvider);
  var watchdetails = await repository.getWatchDetails(selectedWatchId!);
  return watchdetails;
});

final selectedBrandIdProvider = StateProvider<int?>((ref) => null);

final selectedBrandFamilyIdProvider = StateProvider<int?>((ref) => null);

final selectedWatchIdProvider = StateProvider<int?>((ref) => null);
