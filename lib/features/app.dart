import 'package:flutter/material.dart';
import 'package:itunes_music_player/core/configs/configs.dart';
import 'package:itunes_music_player/features/injector.dart';
import 'package:itunes_music_player/features/presentation/providers/config_provider.dart';
import 'package:itunes_music_player/l10n/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'presentation/providers/media_provider.dart';
import 'presentation/providers/player_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di<ConfigProvider>()..init(),
        ),
        ChangeNotifierProvider(create: (_) => di<MediaProvider>()),
        ChangeNotifierProvider(create: (_) => PalyerProvider()),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Consumer<ConfigProvider>(builder: (_, config, __) {
          return MaterialApp(
            title: 'ITunes Music',
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            themeMode: config.themeMode,
            locale: config.locale,
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,
            onGenerateRoute: Navigate.onGenerateRoute,
            debugShowCheckedModeBanner: false,
          );
        }),
      ),
    );
  }
}
