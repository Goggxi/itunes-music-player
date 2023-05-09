import 'package:flutter/material.dart';
import 'package:itunes_music_player/l10n/generated/l10n.dart';

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

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;

  S get lang => S.of(this);
}

extension PaddingExtensions on Widget {
  Padding paddingAll(double value, {Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Padding paddingLTRB(
    double left,
    double top,
    double right,
    double bottom, {
    Key? key,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: this,
      );

  Padding paddingSymmetric({
    Key? key,
    double v = 0.0,
    double h = 0.0,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.symmetric(
          vertical: v,
          horizontal: h,
        ),
        child: this,
      );

  Padding paddingOnly({
    Key? key,
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.only(
          left: left,
          right: right,
          top: top,
          bottom: bottom,
        ),
        child: this,
      );
}
