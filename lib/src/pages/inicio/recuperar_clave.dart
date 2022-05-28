import 'package:flutter/material.dart';
import 'package:my_rutina/main.dart';

class RecuperarClave extends StatefulWidget {
  const RecuperarClave({Key? key}) : super(key: key);

  @override
  State<RecuperarClave> createState() => _RecuperarClaveState();
}

class _RecuperarClaveState extends State<RecuperarClave> {
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _codigo = TextEditingController();
  final TextEditingController _contrasenia = TextEditingController();
  final TextEditingController _repetirContrasenia = TextEditingController();

  bool _codigoIngresado = false;
  bool _correoEnviado = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Theme(
        data: themeData,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: size.height * 0.96,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.96,
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
                            if (_correoEnviado && !_codigoIngresado) {
                              setState(() {
                                _correoEnviado = false;
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
                          child: _correoEnviado
                              ? _correoYaEnviado()
                              : _correoNoEnviado(),
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
    );
  }

  Widget _correoNoEnviado() {
    return Column(
      children: [
        const SizedBox(height: 25),
        TextField(
          controller: _correo,
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
            setState(() {
              _correoEnviado = true;
            });
          },
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _correoYaEnviado() {
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
              setState(() {
                _codigoIngresado = true;
              });
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
            controller: _contrasenia,
            decoration: const InputDecoration(
              hintText: "Nueva clave.",
              hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: _repetirContrasenia,
            decoration: const InputDecoration(
              hintText: "Repetir nueva clave",
              hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            child: const Text(
              "Continuar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 25),
        ],
      );
    }
  }
}
