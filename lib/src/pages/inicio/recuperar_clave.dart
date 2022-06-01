import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_rutina/main.dart';
import 'package:my_rutina/src/utils/alerts.dart';
import 'package:my_rutina/src/utils/web_provider.dart';

import '../../utils/utils.dart';

class RecuperarClave extends StatefulWidget {
  const RecuperarClave({Key? key}) : super(key: key);

  @override
  State<RecuperarClave> createState() => _RecuperarClaveState();
}

class _RecuperarClaveState extends State<RecuperarClave> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _codigo = TextEditingController();
  final TextEditingController _clave = TextEditingController();
  final TextEditingController _repetirClave = TextEditingController();
  final AlertProvider _alertProvider = AlertProvider();
  final WebProvider _webProvider = WebProvider();
  final Utils _utils = Utils();

  bool _codigoIngresado = false;
  bool _emailEnviado = false;
  bool _claveVisible = false;
  bool _repetirClaveVisible = false;

  String codigo = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: themeData,
        child: LayoutBuilder(
          builder: (context, constraints) => Scaffold(
            body: Stack(
              children: [
                Container(
                  height: constraints.maxHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/login.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 10),
                        child: IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                                color: Colors.teal[300]),
                            onPressed: () {
                              if (_emailEnviado && !_codigoIngresado) {
                                setState(() {
                                  _emailEnviado = false;
                                });
                              } else if (_codigoIngresado) {
                                setState(() {
                                  _codigoIngresado = false;
                                });
                              } else {
                                Navigator.of(context).pop();
                              }
                            }),
                      ),
                      Expanded(child: Container()),
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: const Text(
                          "Recuperar clave",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 27),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 5),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 0.65),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: _emailEnviado
                                ? _emailYaEnviado()
                                : _emailNoEnviado(),
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
    );
  }

  Widget _emailNoEnviado() {
    return Column(
      children: [
        const SizedBox(height: 25),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: _email,
          decoration: const InputDecoration(
            hintText: "Correo",
            hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          "Te enviaremos un correo a esta dirección,\r\ncon un código para poder recuperar tu clave.",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),
        const Text(
          "Si no recibió el código, revise su bandeja de Spam.",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),
        ElevatedButton(
          child: const Text(
            "Enviar",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            _recuperarClave();
          },
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _emailYaEnviado() {
    if (!_codigoIngresado) {
      return Column(
        children: [
          const SizedBox(height: 25),
          TextField(
            controller: _codigo,
            decoration: const InputDecoration(
              hintText: "EJ: 34133433",
              hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "Ingrese el código que recibió en su correo.",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          const Text(
            "Si no recibió el código, revise su bandeja de Spam.",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            child: const Text(
              "Continuar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _verificarCodigo();
            },
          ),
          const SizedBox(height: 25),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 25),
          TextField(
            controller: _clave,
            decoration: InputDecoration(
              hintText: "Nueva clave.",
              hintStyle: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
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
            ),
            obscureText: _claveVisible,
          ),
          const SizedBox(height: 25),
          TextField(
            controller: _repetirClave,
            decoration: InputDecoration(
              hintText: "Repetir nueva clave",
              hintStyle: const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
              suffixIcon: _repetirClaveVisible
                  ? IconButton(
                      icon: Icon(Icons.lock_open, color: Colors.teal[400]),
                      onPressed: () {
                        setState(() {
                          _repetirClaveVisible = false;
                        });
                      })
                  : IconButton(
                      icon: Icon(Icons.lock_outline, color: Colors.teal[400]),
                      onPressed: () {
                        setState(() {
                          _repetirClaveVisible = true;
                        });
                      }),
            ),
            obscureText: _repetirClaveVisible,
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            child: const Text(
              "Continuar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _cambiarClave();
            },
          ),
          const SizedBox(height: 25),
        ],
      );
    }
  }

  _recuperarClave() async {
    if (_email.text != "" && _email.text.contains("@")) {
      _alertProvider.showLoadingDialog(context, keyLoader);
      codigo = _utils.randomCodigo();
      Map parametros = {
        "email": _email.text,
        "codigo": codigo,
      };

      var respuesta =
          await _webProvider.llamarFuncion("recuperarClave", parametros);
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      if (respuesta.toString().contains('Error')) {
        showDialog(
            context: context,
            builder: (context) {
              return _alertProvider.showErrorDialog(
                  context, "Error al recuperar clave.\r\n$respuesta");
            });
      } else {
        setState(() {
          _emailEnviado = true;
        });
      }
    }
  }

  _verificarCodigo() {
    if (_codigo.text == codigo) {
      setState(() {
        _codigoIngresado = true;
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return _alertProvider.showErrorDialog(
                context, "El código ingresado es incorrecto.");
          });
    }
  }

  _cambiarClave() async {
    if (_clave.text != "" && _clave.text == _repetirClave.text) {
      _alertProvider.showLoadingDialog(context, keyLoader);
      codigo = _utils.randomCodigo();
      Map parametros = {
        "email": _email.text,
        "clave": _utils.md5Encode(_clave.text),
      };

      String respuesta =
          await _webProvider.llamarFuncion("cambiarClave", parametros);
      Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      if (respuesta == "1") {
        showDialog(
                context: context,
                builder: (context) {
                  return _alertProvider.showSuccessDialog(
                      context, "Clave cambiada con éxto.");
                })
            .then((value) =>
                Navigator.of(context).pushReplacementNamed("login_page"));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return _alertProvider.showErrorDialog(context, respuesta);
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return _alertProvider.showErrorDialog(
                context, "Las contraseñas ingresadas no coinciden.");
          });
    }
  }
}
