import 'package:flutter/material.dart';
import 'package:itunes_music_player/features/presentation/pages/pages.dart';

class Navigate {
  static const String home = '/';
  static const String player = '/player';

  static MaterialPageRoute _pageRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _pageRoute(const HomePage());
      case player:
        return _pageRoute(const PlayerPage());
      default:
        return _pageRoute(const _NotFoundPage());
    }
  }
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Page not found')),
    );
  }
}
