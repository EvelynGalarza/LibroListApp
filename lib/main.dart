import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prylibro/src/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
        scaffoldBackgroundColor: const Color(0xA6140F46),
      ),
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("LIBROLIST"),
          ),
          body: const HomePage()),
    );
  }
}
