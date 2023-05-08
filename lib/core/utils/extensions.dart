import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  void popPage<T extends Object?>([T? result]) => Navigator.pop(this, result);

  Future<T?> pushPage<T extends Object?>(Widget page) => Navigator.push(
        this,
        MaterialPageRoute(builder: (_) => page),
      );

  Future<T?> pushNamed<T extends Object?>(
    String screenName, {
    Object? arguments,
  }) async =>
      Navigator.of(this).pushNamed<T>(
        screenName,
        arguments: arguments,
      );
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;
}
