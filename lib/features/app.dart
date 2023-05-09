import 'package:flutter/material.dart';
import 'package:itunes_music_player/core/configs/configs.dart';
import 'package:itunes_music_player/features/injector.dart';
import 'package:provider/provider.dart';

import 'presentation/providers/media_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di<MediaProvider>()),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          title: 'ITunes Music',
          theme: ThemeData(primarySwatch: Colors.blue),
          onGenerateRoute: Navigate.onGenerateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
