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
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return LandscapeTabLayout(
              selectedTabIndex: selectedTabIndex,
              onTabChanged: (index) {
                context.read(selectedTabIndexProvider).state = index;
              },
            );
          } else {
            return PortraitTabLayout(
              selectedTabIndex: selectedTabIndex,
              onTabChanged: (index) {
                context.read(selectedTabIndexProvider).state = index;
              },
            );
          }
        },
      ),
    );
  }
}

class LandscapeTabLayout extends StatelessWidget {
  final int selectedTabIndex;
  final ValueChanged<int> onTabChanged;

  const LandscapeTabLayout({
    required this.selectedTabIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TabBarWidget(
            selectedTabIndex: selectedTabIndex,
            onTabChanged: onTabChanged,
          ),
        ),
        Expanded(
          flex: 2,
          child: TabContentWidget(selectedTabIndex: selectedTabIndex),
        ),
      ],
    );
  }
}

class PortraitTabLayout extends StatelessWidget {
  final int selectedTabIndex;
  final ValueChanged<int> onTabChanged;

  const PortraitTabLayout({
    required this.selectedTabIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBarWidget(
          selectedTabIndex: selectedTabIndex,
          onTabChanged: onTabChanged,
        ),
        Expanded(
          child: TabContentWidget(selectedTabIndex: selectedTabIndex),
        ),
      ],
    );
  }
}

class TabBarWidget extends StatelessWidget {
  final int selectedTabIndex;
  final ValueChanged<int> onTabChanged;

  const TabBarWidget({
    required this.selectedTabIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(text: 'Tab 1'),
        Tab(text: 'Tab 2'),
      ],
      onTap: onTabChanged,
      currentIndex: selectedTabIndex,
    );
  }
}

class TabContentWidget extends StatelessWidget {
  final int selectedTabIndex;

  const TabContentWidget({required this.selectedTabIndex});

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: selectedTabIndex,
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

// Remaining page widgets...

class Tab1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tab 1 Page'),
    );
  }
}

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tab 2 Page'),
    );
  }
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Text('Details Page'),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
