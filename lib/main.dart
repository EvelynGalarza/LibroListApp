// ignore_for_file: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:prylibro/src/pages/home_page.dart';
import 'package:prylibro/src/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prylibro/src/pages/setting_page.dart';
import 'package:prylibro/src/pages/splash_page.dart';
import 'package:prylibro/src/providers/providers.dart';
import 'package:prylibro/src/providers/usuario_provider.dart';
import 'package:prylibro/src/widgets/register_widget.dart';
import 'dart:developer' as developer;
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  developer.log('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //se asegure que este inicializado
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //carga notificaciones apagada la aplicacion
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      developer.log('A new onMessageOpenedApp event was published!');
    });
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _setupToken();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return FutureBuilder<bool>(
        future: mainProvider.getPreferences(),
        builder: (context, snapshot) {
          //CARGA firebase
          CollectionReference usuario =
              FirebaseFirestore.instance.collection('usuario');
          if (snapshot.hasData) {
            try {
              return ScreenUtilInit(
                  designSize: const Size(360, 690),
                  builder: () => MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Libro List',
                      theme: AppTheme.themeData(mainProvider.mode),
                      routes: {
                        "/splash": (context) => const SplashScreen(
                              title: '',
                            ),
                        "/singUp": (context) => const RegisterWidget(),
                        "/settings": (context) => SettingPage(
                              currentUsuario: usuario,
                            )
                      },
                      home: const SplashScreen(
                        title: '',
                      )));
            } catch (e) {
              //print(e);
            }
          }
          return const SizedBox.square(
              dimension: 100.0, child: CircularProgressIndicator());
        });
  }

//Notificaciones
  _setupToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    developer.log(token ?? "");
  }
}
