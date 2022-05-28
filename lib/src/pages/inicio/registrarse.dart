import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_rutina/main.dart';
import 'package:my_rutina/src/utils/utils.dart';
import 'package:my_rutina/src/utils/web_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nombreCompleto = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _dni = TextEditingController();
  final TextEditingController _clave = TextEditingController();
  final TextEditingController _repetirClave = TextEditingController();
  final WebProvider _webProvider = WebProvider();
  final Utils _utils = Utils();

  bool _datosIniciales = true;
  bool _visibleContrasenia = false;
  bool _visibleRepetirContrasenia = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Theme(
        data: themeData,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.97,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/login.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.9,
                  child: _datosIniciales ? _wDatosIniciales() : _wPassword(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _wDatosIniciales() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 10),
          child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.teal[300]),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        Expanded(child: Container()),
        Container(
          margin: const EdgeInsets.only(left: 40),
          child: const Text(
            "Registrarse",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.65),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                TextField(
                  controller: _nombreCompleto,
                  decoration: const InputDecoration(
                    hintText: "Nombre completo",
                    hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _dni,
                  decoration: const InputDecoration(
                    hintText: "D.N.I",
                    hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _telefono,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Telefono",
                    hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Correo",
                    hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  child: const Text(
                    "Siguiente",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      _datosIniciales = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _wPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.teal[300]),
            onPressed: () {
              setState(() {});
            },
          ),
        ),
        Expanded(child: Container()),
        Container(
          margin: const EdgeInsets.only(left: 40),
          child: const Text(
            "Registrarse",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.65),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                TextField(
                  obscureText: _visibleContrasenia ? false : true,
                  controller: _clave,
                  decoration: InputDecoration(
                    hintText: "Contraseña",
                    hintStyle:
                        const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                    suffixIcon: _visibleContrasenia
                        ? IconButton(
                            icon:
                                Icon(Icons.lock_open, color: Colors.teal[400]),
                            onPressed: () {
                              setState(() {
                                _visibleContrasenia = false;
                              });
                            })
                        : IconButton(
                            icon: Icon(Icons.lock_outline,
                                color: Colors.teal[400]),
                            onPressed: () {
                              setState(() {
                                _visibleContrasenia = true;
                              });
                            }),
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  obscureText: _visibleRepetirContrasenia ? false : true,
                  controller: _repetirClave,
                  decoration: InputDecoration(
                    hintText: "Repetir contraseña",
                    hintStyle:
                        const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                    suffixIcon: _visibleRepetirContrasenia
                        ? IconButton(
                            icon:
                                Icon(Icons.lock_open, color: Colors.teal[400]),
                            onPressed: () {
                              setState(() {
                                _visibleRepetirContrasenia = false;
                              });
                            })
                        : IconButton(
                            icon: Icon(Icons.lock_outline,
                                color: Colors.teal[400]),
                            onPressed: () {
                              setState(() {
                                _visibleRepetirContrasenia = true;
                              });
                            }),
                  ),
                ),
                const Text(
                  "AGREGAR VERIFICACION SI LAS CONTRASEÑAS COINCIDEN, MIENTRAS ESCRIBE",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  child: const Text(
                    "Registrarse",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_clave.text != "" &&
                        _repetirClave.text != "" &&
                        _clave.text == _repetirClave.text) {
                      _registrarse();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _registrarse() async {
    Map parametros = {
      "nombre": _nombreCompleto.text,
      "dni": _dni.text,
      "telefono": _telefono.text,
      "email": _email.text,
      "clave": _utils.md5Encode(_clave.text)
    };

    var respuesta =
        await _webProvider.llamarFuncion("login", jsonEncode(parametros));
    var hola = "";
  }
}
