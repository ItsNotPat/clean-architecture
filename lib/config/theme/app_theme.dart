import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: false,
    textTheme: GoogleFonts.interTextTheme(),
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black12),
    titleTextStyle: TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
  );
}
