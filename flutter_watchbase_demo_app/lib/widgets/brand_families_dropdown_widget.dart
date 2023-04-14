import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_watchbase_demo_app/main.dart';

class BrandFamiliesDropdownWidget extends StatelessWidget {
  const BrandFamiliesDropdownWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var brandFamilies = ref.watch(brandFamiliesProvider);

        return brandFamilies.when(
          data: (families) {
            return DropdownButton<int?>(
              value: ref.watch(selectedBrandFamilyIdProvider),
              items: families
                  .map(
                    (family) => DropdownMenuItem<int?>(
                      value: family.id,
                      child: Text(family.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                ref.read(selectedBrandFamilyIdProvider.notifier).state = value!;
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
