import 'package:flutter/material.dart';
import 'background_work/background_fetch.dart';
import 'Screens/splashScreen.dart';
import 'package:background_fetch/background_fetch.dart';
void main() {
  // Enable integration testing with the Flutter Driver extension.
  // See https://flutter.io/testing/ for more info.
  runApp(new MyApp());

  // Register to receive BackgroundFetch events after app is terminated.
  // Requires {stopOnTerminate: false, enableHeadless: true}
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      checkerboardRasterCacheImages: false,
      checkerboardOffscreenLayers: false,

      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


