import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_watchbase_demo_app/main.dart';
import 'package:flutter_watchbase_demo_app/pages/watchdetails_page.dart';

class WatchesGridWidget extends StatelessWidget {
  const WatchesGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        var watchesAsyncValue = ref.watch(watchesProvider);
        // TEMP
        var watchDetailsAsyncValue = ref.watch(watchDetailsProvider);

        return watchesAsyncValue.when(data: (watches) {
          return Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              children: watches.map((watch) {
                return Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      ref.read(selectedWatchIdProvider.notifier).state = watch.id;
                      Navigator.pushNamed(context, WatchDetailsPage.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130.0,
                          height: 130.0,
                          child: Image.network(watch.thumb),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          watch.refnr,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            watch.name,
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }, error: (error, stack) {
          return Text('Error: $error');
        }, loading: () {
          return const CircularProgressIndicator();
        });
      },
    );
  }
}
