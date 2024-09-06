import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff425e91),
      surfaceTint: Color(0xff425e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd7e2ff),
      onPrimaryContainer: Color(0xff001b3f),
      secondary: Color(0xff705d0d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffce186),
      onSecondaryContainer: Color(0xff231b00),
      tertiary: Color(0xff246488),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc8e6ff),
      onTertiaryContainer: Color(0xff001e2f),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1c20),
      onSurfaceVariant: Color(0xff44474e),
      outline: Color(0xff74777f),
      outlineVariant: Color(0xffc4c6d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3036),
      inversePrimary: Color(0xffabc7ff),
      primaryFixed: Color(0xffd7e2ff),
      onPrimaryFixed: Color(0xff001b3f),
      primaryFixedDim: Color(0xffabc7ff),
      onPrimaryFixedVariant: Color(0xff294677),
      secondaryFixed: Color(0xfffce186),
      onSecondaryFixed: Color(0xff231b00),
      secondaryFixedDim: Color(0xffdfc56d),
      onSecondaryFixedVariant: Color(0xff554500),
      tertiaryFixed: Color(0xffc8e6ff),
      onTertiaryFixed: Color(0xff001e2f),
      tertiaryFixedDim: Color(0xff94cdf7),
      onTertiaryFixedVariant: Color(0xff004c6e),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff254273),
      surfaceTint: Color(0xff425e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5975a9),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff514100),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff887324),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff004768),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3f7aa0),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1c20),
      onSurfaceVariant: Color(0xff40434a),
      outline: Color(0xff5c5f67),
      outlineVariant: Color(0xff787a83),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3036),
      inversePrimary: Color(0xffabc7ff),
      primaryFixed: Color(0xff5975a9),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff405c8e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff887324),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff6d5a0a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff3f7aa0),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff216186),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00214c),
      surfaceTint: Color(0xff425e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff254273),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2a2100),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff514100),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002538),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff004768),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff21242b),
      outline: Color(0xff40434a),
      outlineVariant: Color(0xff40434a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3036),
      inversePrimary: Color(0xffe5ecff),
      primaryFixed: Color(0xff254273),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff072c5c),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff514100),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff372c00),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff004768),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003048),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffabc7ff),
      surfaceTint: Color(0xffabc7ff),
      onPrimary: Color(0xff0d2f5f),
      primaryContainer: Color(0xff294677),
      onPrimaryContainer: Color(0xffd7e2ff),
      secondary: Color(0xffdfc56d),
      onSecondary: Color(0xff3b2f00),
      secondaryContainer: Color(0xff554500),
      onSecondaryContainer: Color(0xfffce186),
      tertiary: Color(0xff94cdf7),
      onTertiary: Color(0xff00344d),
      tertiaryContainer: Color(0xff004c6e),
      onTertiaryContainer: Color(0xffc8e6ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111318),
      onSurface: Color(0xffe2e2e9),
      onSurfaceVariant: Color(0xffc4c6d0),
      outline: Color(0xff8e9099),
      outlineVariant: Color(0xff44474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff425e91),
      primaryFixed: Color(0xffd7e2ff),
      onPrimaryFixed: Color(0xff001b3f),
      primaryFixedDim: Color(0xffabc7ff),
      onPrimaryFixedVariant: Color(0xff294677),
      secondaryFixed: Color(0xfffce186),
      onSecondaryFixed: Color(0xff231b00),
      secondaryFixedDim: Color(0xffdfc56d),
      onSecondaryFixedVariant: Color(0xff554500),
      tertiaryFixed: Color(0xffc8e6ff),
      onTertiaryFixed: Color(0xff001e2f),
      tertiaryFixedDim: Color(0xff94cdf7),
      onTertiaryFixedVariant: Color(0xff004c6e),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1c20),
      surfaceContainer: Color(0xff1e2025),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb2cbff),
      surfaceTint: Color(0xffabc7ff),
      onPrimary: Color(0xff001536),
      primaryContainer: Color(0xff7591c7),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe3c971),
      onSecondary: Color(0xff1c1600),
      secondaryContainer: Color(0xffa68f3e),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff98d1fb),
      onTertiary: Color(0xff001827),
      tertiaryContainer: Color(0xff5d97be),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xfffbfaff),
      onSurfaceVariant: Color(0xffc8cad4),
      outline: Color(0xffa0a2ac),
      outlineVariant: Color(0xff80838c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff2a4879),
      primaryFixed: Color(0xffd7e2ff),
      onPrimaryFixed: Color(0xff00102c),
      primaryFixedDim: Color(0xffabc7ff),
      onPrimaryFixedVariant: Color(0xff153566),
      secondaryFixed: Color(0xfffce186),
      onSecondaryFixed: Color(0xff161100),
      secondaryFixedDim: Color(0xffdfc56d),
      onSecondaryFixedVariant: Color(0xff423500),
      tertiaryFixed: Color(0xffc8e6ff),
      onTertiaryFixed: Color(0xff00131f),
      tertiaryFixedDim: Color(0xff94cdf7),
      onTertiaryFixedVariant: Color(0xff003a55),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1c20),
      surfaceContainer: Color(0xff1e2025),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbfaff),
      surfaceTint: Color(0xffabc7ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb2cbff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe3c971),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff9fbff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff98d1fb),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffbfaff),
      outline: Color(0xffc8cad4),
      outlineVariant: Color(0xffc8cad4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff032959),
      primaryFixed: Color(0xffdee7ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb2cbff),
      onPrimaryFixedVariant: Color(0xff001536),
      secondaryFixed: Color(0xffffe592),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe3c971),
      onSecondaryFixedVariant: Color(0xff1c1600),
      tertiaryFixed: Color(0xffd1eaff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff98d1fb),
      onTertiaryFixedVariant: Color(0xff001827),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1c20),
      surfaceContainer: Color(0xff1e2025),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
