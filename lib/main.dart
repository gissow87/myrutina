import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_rutina/src/pages/inicio/login.dart';
import 'package:my_rutina/src/pages/inicio/recuperar_clave.dart';
import 'package:my_rutina/src/pages/inicio/registrarse.dart';
import 'package:my_rutina/src/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/pages/entrenador/inicio_entrenador.dart';
import 'src/pages/usuario/inicio_usuario.dart';

final GlobalKey<State> keyLoader = GlobalKey<State>();
SharedPreferences? prefs;

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: HexColor.fromHex("#31454C"),
  //textField
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    filled: true,
    fillColor: Color.fromRGBO(227, 237, 237, 1),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  ),
  //ElevatedButton
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    primary: Colors.teal[300],
    padding: const EdgeInsets.all(20),
  )),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(systemNavigationBarColor: Colors.black, systemNavigationBarIconBrightness: Brightness.light));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Rutina',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "login_page",
        routes: {
          "login_page": (BuildContext context) => const LoginPage(),
          "register_page": (BuildContext context) => const RegisterPage(),
          "recuperar_clave": (BuildContext context) => const RecuperarClave(),
          "inicio_entrenador": (BuildContext context) => const InicioEntrenador(),
          "inicio_usuario": (BuildContext context) => const InicioUsuario(),
        });
  }
}
