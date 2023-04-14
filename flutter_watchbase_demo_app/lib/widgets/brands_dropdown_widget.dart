import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_watchbase_demo_app/main.dart';

class BrandsDropdownWidget extends StatelessWidget {
  const BrandsDropdownWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final brandsAsyncValue = ref.watch(brandsProvider);

        return brandsAsyncValue.when(
          data: (brands) {
            return DropdownButton<int?>(
              value: ref.watch(selectedBrandIdProvider),
              items: brands
                  .map(
                    (brand) => DropdownMenuItem<int?>(
                      value: brand.id,
                      child: Text(brand.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                ref.read(selectedBrandIdProvider.notifier).state = value!;
                ref.invalidate(selectedBrandFamilyIdProvider);
              },
            );
          },
          error: (error, stack) {
            return Text('Error: $error');
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        );
      },
    );
  }
}
