import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<int, Color> color = {
  50: const Color(0xFF3E2158), //10%
  100: const Color(0xFF030118), //20%
  200: const Color(0xFFFAF7F6), //30%
  300: const Color(0xA6A69FF3), //40%
  400: const Color(0xA6564BCA), //50%
  500: const Color(0xA6322994), //60%
  600: const Color(0xA6201A64), //70%
  700: const Color(0xA6A69FF3), //80%
  800: const Color(0xA6140F46), //90%
  900: const Color(0xA608061D), //100%
};
MaterialColor colorCustom = MaterialColor(0xFF3B4499, color);

// class TemaProvider extends GetxController {
//   late SharedPreferences preferences;

//   String prefkey = "isDarkModeKey";

//   void temaClaro() {
//     Get.changeTheme(ThemeData.light());
//     preferences.setBool(prefkey, false);
//   }

//   void temaOscuro() {
//     Get.changeTheme(ThemeData.dark());
//     preferences.setBool(prefkey, true);
//   }

//   void temaPersonalizado() {
//     Get.changeTheme(ThemeData(
//         // buttonColor: Colors.amber,
//         primaryColor: Colors.black,
//         appBarTheme: const AppBarTheme(color: Colors.indigo)));
//   }

//   @override
//   void onInit() {
//     cargarPreferencias().then((value) => cargarTema());

//     super.onInit();
//   }

//   void cargarTema() {
//     bool? isDarkMode = preferences.getBool(prefkey);

//     if (isDarkMode == null) {
//       preferences.setBool(prefkey, false);
//       isDarkMode = false;
//     }

//     (isDarkMode) ? temaOscuro() : temaClaro();
//   }

//   Future<void> cargarPreferencias() async {
//     preferences = await Get.putAsync<SharedPreferences>(
//         () async => await SharedPreferences.getInstance());
//   }
// }

class AppTheme {
  static const Color colorMediumPriority = Colors.orange;
  static const Color colorHighPriority = Colors.amber;
  static final Color colorLowPriority = Colors.green.shade100;

  static final TextTheme textTheme = TextTheme(
    headline1: _headLine1,
    headline2: _headLine2,
    headline3: _headLine3,
    headline4: _headLine4,
    headline5: _headLine5,
    headline6: _headLine6,
    bodyText1: _bodyText1,
    bodyText2: _bodyText2,
    subtitle1: _subTitle1,
    subtitle2: _subTitle2,
    caption: _caption,
  );

  static const TextStyle _headLine1 =
      TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold);

  static final TextStyle _headLine2 = _headLine1.copyWith();
  static final TextStyle _headLine3 = _headLine2.copyWith();
  static final TextStyle _headLine4 = _headLine3.copyWith();
  static final TextStyle _headLine5 = _headLine4.copyWith();
  static final TextStyle _headLine6 =
      _headLine5.copyWith(fontFamily: 'Akrobat');
  static final TextStyle _subTitle1 = _headLine6.copyWith();
  static final TextStyle _subTitle2 = _subTitle1.copyWith();
  static final TextStyle _bodyText1 = _subTitle2.copyWith();
  static final TextStyle _bodyText2 = _bodyText1.copyWith();
  static final TextStyle _caption = _bodyText2.copyWith();

  static ThemeData themeData(bool ligthMode) {
    return ThemeData(
        primaryColor: const Color(0xFF3E2158),
        primaryColorDark: const Color(0xFF9FA8DA),
        primaryColorLight: const Color(0xFF448AFF),
        tabBarTheme: TabBarTheme(
            unselectedLabelColor: Colors.grey,
            labelColor: ligthMode ? const Color(0xFF3F51B5) : Colors.white),
        colorScheme: ColorScheme(
            primary: const Color(0xFF283593),
            primaryVariant: const Color(0xFF9FA8DA),
            secondary: const Color(0xFF448AFF),
            secondaryVariant: const Color(0xA6A69FF3),
            surface: Colors.white,
            background: Colors.grey,
            error: Colors.red,
            onPrimary: Colors.white,
            onSecondary: Colors.black,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.white,
            brightness: ligthMode ? Brightness.light : Brightness.dark),
        textTheme: textTheme);
  }
}
