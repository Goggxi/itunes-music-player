import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/app.dart';
import 'features/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(const App()),
  );
}
