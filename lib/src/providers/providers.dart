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
  700: const Color(0xA619144E), //80%
  800: const Color(0xA6140F46), //90%
  900: const Color(0xA608061D), //100%
};
MaterialColor colorCustom = MaterialColor(0xFF3B4499, color);

class TemaProvider extends GetxController {
  late SharedPreferences preferences;

  String prefkey = "isDarkModeKey";

  void temaClaro() {
    Get.changeTheme(ThemeData.light());
    preferences.setBool(prefkey, false);
  }

  void temaOscuro() {
    Get.changeTheme(ThemeData.dark());
    preferences.setBool(prefkey, true);
  }

  void temaPersonalizado() {
    Get.changeTheme(ThemeData(
        // buttonColor: Colors.amber,
        primaryColor: Colors.black,
        appBarTheme: const AppBarTheme(color: Colors.indigo)));
  }

  @override
  void onInit() {
    cargarPreferencias().then((value) => cargarTema());

    super.onInit();
  }

  void cargarTema() {
    bool? isDarkMode = preferences.getBool(prefkey);

    if (isDarkMode == null) {
      preferences.setBool(prefkey, false);
      isDarkMode = false;
    }

    (isDarkMode) ? temaOscuro() : temaClaro();
  }

  Future<void> cargarPreferencias() async {
    preferences = await Get.putAsync<SharedPreferences>(
        () async => await SharedPreferences.getInstance());
  }
}
