import 'package:flutter/material.dart';
import 'package:itunes_music_player/core/configs/configs.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'ITunes Music',
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: Navigate.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
