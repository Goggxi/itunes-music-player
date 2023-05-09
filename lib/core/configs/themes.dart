import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppThemes {
  static EdgeInsets get paddingDefault => const EdgeInsets.all(16);

  static ThemeData get light {
    return ThemeData.light(useMaterial3: true).copyWith(
      textTheme: GoogleFonts.montserratTextTheme(),
    );
  }

  static ThemeData get dark {
    return ThemeData.dark(useMaterial3: true).copyWith(
      textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
    );
  }
}
