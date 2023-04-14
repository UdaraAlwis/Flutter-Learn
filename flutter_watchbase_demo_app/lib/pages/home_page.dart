import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_watchbase_demo_app/main.dart';
import 'package:flutter_watchbase_demo_app/widgets/brand_families_dropdown_widget.dart';
import 'package:flutter_watchbase_demo_app/widgets/brands_dropdown_widget.dart';
import 'package:flutter_watchbase_demo_app/widgets/watches_grid_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchbase Demo App'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BrandsDropdownWidget(),
                  const SizedBox(width: 20),
                  if (ref.watch(selectedBrandIdProvider) != null) const BrandFamiliesDropdownWidget(),
                ],
              ),
              const SizedBox(height: 5),
              if (ref.watch(selectedBrandFamilyIdProvider) != null) const WatchesGridWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
