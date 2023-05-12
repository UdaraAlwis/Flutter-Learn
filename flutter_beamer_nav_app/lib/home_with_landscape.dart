import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final selectedTabIndex = watch(selectedTabIndexProvider).state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLandscape = constraints.maxWidth > constraints.maxHeight;

          return isLandscape
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TabBar(
                        tabs: [
                          Tab(text: 'Tab 1'),
                          Tab(text: 'Tab 2'),
                        ],
                        onTap: (index) {
                          context.read(selectedTabIndexProvider).state = index;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IndexedStack(
                        index: selectedTabIndex,
                        children: [
                          Tab1Page(),
                          Tab2Page(),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: 'Tab 1'),
                        Tab(text: 'Tab 2'),
                      ],
                      onTap: (index) {
                        context.read(selectedTabIndexProvider).state = index;
                      },
                    ),
                    Expanded(
                      child: IndexedStack(
                        index: selectedTabIndex,
                        children: [
                          Tab1Page(),
                          Tab2Page(),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
