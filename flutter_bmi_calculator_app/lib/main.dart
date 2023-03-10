import 'package:flutter/material.dart';
import 'screens/input_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(500, 900),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(BMICalculator());
}

// For fixing Flutter ThemeData.primaryColor bug: https://github.com/flutter/flutter/issues/104311
MaterialColor appColor = const MaterialColor(
  0xFF0A0E21,
  <int, Color>{
    50: const Color(0xFF0A0E21),
    100: const Color(0xFF0A0E21),
    200: const Color(0xFF0A0E21),
    300: const Color(0xFF0A0E21),
    400: const Color(0xFF0A0E21),
    500: const Color(0xFF0A0E21),
    600: const Color(0xFF0A0E21),
    700: const Color(0xFF0A0E21),
    800: const Color(0xFF0A0E21),
    900: const Color(0xFF0A0E21),
  },
);

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Color(0xFF0A0E21), secondary: Colors.purple),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: InputPage(),
    );
  }
}
