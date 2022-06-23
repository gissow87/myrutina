import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_rutina/src/utils/alerts.dart';

import '../../../main.dart';
import '../../utils/utils.dart';
import '../../utils/web_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _clave = TextEditingController();
  final AlertProvider _alertProvider = AlertProvider();
  final WebProvider _webProvider = WebProvider();
  final Utils _utils = Utils();

  bool _claveVisible = false;
  bool _recordarCuenta = false;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _email.text = prefs!.getString("emailInicio") ?? "";
    _clave.text = prefs!.getString("claveInicio") ?? "";
    _recordarCuenta = prefs!.getBool("recordarCuenta") ?? false;
    setState(() {
      _isLoading = false;
    });
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _utils.logoPage(context);
    } else {
      return SafeArea(
        child: Theme(
          data: themeData,
          child: LayoutBuilder(
            builder: (context, constraints) => Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: constraints.maxHeight,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/images/login.jpg"),
                        fit: BoxFit.cover,
                      )),
                    ),
                    SizedBox(
                      height: constraints.maxHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: Container()),
                          Container(
                            margin: const EdgeInsets.only(left: 40),
                            child: const Text(
                              "Bienvenido!",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 0.65),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _email,
                                      decoration: const InputDecoration(
                                        hintText: "Correo",
                                        hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    TextField(
                                      controller: _clave,
                                      decoration: InputDecoration(
                                        hintText: "Contraseña",
                                        suffixIcon: _claveVisible
                                            ? IconButton(
                                                icon: Icon(Icons.lock_open, color: Colors.teal[400]),
                                                onPressed: () {
                                                  setState(() {
                                                    _claveVisible = false;
                                                  });
                                                })
                                            : IconButton(
                                                icon: Icon(Icons.lock_outline, color: Colors.teal[400]),
                                                onPressed: () {
                                                  setState(() {
                                                    _claveVisible = true;
                                                  });
                                                }),
                                        hintStyle: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                                      ),
                                      obscureText: _claveVisible ? false : true,
                                    ),
                                    const SizedBox(height: 25),
                                    const Text("¿Aún no tienes cuenta?", style: TextStyle(color: Colors.white)),
                                    const SizedBox(height: 25),
                                    InkWell(
                                      child: Text("Registrate aquí", style: TextStyle(color: Colors.tealAccent[400])),
                                      onTap: () {
                                        Navigator.pushNamed(context, "register_page");
                                      },
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Flexible(child: Text("Recordar cuenta", style: TextStyle(color: Colors.white))),
                                        Checkbox(
                                            checkColor: Colors.black,
                                            fillColor: MaterialStateProperty.all(
                                              Colors.white,
                                            ),
                                            value: _recordarCuenta,
                                            onChanged: (value) {
                                              setState(() {
                                                _recordarCuenta = value!;
                                              });
                                            })
                                      ],
                                    ),
                                    ElevatedButton(
                                      child: const Text(
                                        "Iniciar sesión",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        _login();
                                      },
                                    ),
                                    const SizedBox(height: 25),
                                    InkWell(
                                      child: Text("¿Olvidaste tu contraseña?\r\nToca aquí para recuperarla.",
                                          style: TextStyle(color: Colors.tealAccent[400])),
                                      onTap: () {
                                        Navigator.pushNamed(context, "recuperar_clave");
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  _login() async {
    _alertProvider.showLoadingDialog(context, keyLoader);
    Map parametros = {"email": _email.text, "clave": _utils.md5Encode(_clave.text)};

    var respuesta = await _webProvider.llamarFuncion("login", parametros);
    Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
    if (respuesta == "null") {
      showDialog(
          context: context,
          builder: (context) {
            return _alertProvider.showErrorDialog(context, "Usuario no encontrado.");
          });
    } else {
      Map mUsuario = jsonDecode(respuesta);
      prefs?.setString("idUsuario", mUsuario["id"]);
      prefs?.setString("nombreUsuario", mUsuario["nombre"]);
      prefs?.setString("dniUsuario", mUsuario["dni"]);
      prefs?.setString("emailUsuario", mUsuario["email"]);
      if (mUsuario["es_entrenador"] == "1") {
        prefs?.setBool("es_entrenador", true);
      } else {
        prefs?.setBool("es_entrenador", false);
      }

      if (_recordarCuenta) {
        prefs?.setString("emailInicio", _email.text);
        prefs?.setString("claveInicio", _clave.text);
        prefs?.setBool("recordarCuenta", true);
      } else {
        prefs?.setString("emailInicio", "");
        prefs?.setString("claveInicio", "");
        prefs?.setBool("recordarCuenta", true);
      }

      if (mUsuario["es_entrenador"] == "1") {
        Navigator.pushReplacementNamed(context, "inicio_entrenador");
      } else {
        Navigator.pushReplacementNamed(context, "inicio_usuario");
      }
    }
  }
}
