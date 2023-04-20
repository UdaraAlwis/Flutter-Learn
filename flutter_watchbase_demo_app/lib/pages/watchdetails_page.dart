import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_watchbase_demo_app/main.dart';

class WatchDetailsPage extends ConsumerStatefulWidget {
  const WatchDetailsPage({super.key});
  static String id = 'watchdetails_page';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WatchDetailsPageState();
}

class _WatchDetailsPageState extends ConsumerState<WatchDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Watchbase Demo App'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer(
              builder: (context, ref, child) {
                var watchDetailsAsyncValue = ref.watch(watchDetailsProvider);

                return watchDetailsAsyncValue.when(data: (watchDetails) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (watchDetails.brand?.name != null)
                            Text(
                              "${watchDetails.brand?.name}",
                              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w100),
                            ),
                          if (watchDetails.family?.name != null)
                            Text(
                              "${watchDetails.family?.name}",
                              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                            ),
                          if (watchDetails.name != null)
                            Text(
                              "${watchDetails.name}",
                              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (watchDetails.images != null && watchDetails.images!.isNotEmpty)
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: Image.network(watchDetails.images!.first),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (watchDetails.released != null)
                            Text(
                              "Realsed: ${watchDetails.released}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                            ),
                          if (watchDetails.description != null)
                            Text(
                              "${watchDetails.description}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (watchDetails.caliber != null)
                            Text(
                              "Caliber: ${watchDetails.caliber!.brand}",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                            ),
                          if (watchDetails.caliber!.image != null)
                            SizedBox(
                              height: 200,
                              width: 200,
                              child: Image.network(watchDetails.caliber!.image!),
                            ),
                          if (watchDetails.caliber!.description != null)
                            Text(
                              "${watchDetails.caliber!.description}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                            ),
                        ],
                      ),
                    ),
                  );
                }, error: (error, stack) {
                  return Text('Error: $error');
                }, loading: () {
                  return const Center(child: CircularProgressIndicator());
                });
              },
            )),
      );
    });
  }
}
