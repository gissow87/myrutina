import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../utils/utils.dart';
import '../../utils/web_provider.dart';

class InicioEntrenador extends StatefulWidget {
  const InicioEntrenador({Key? key}) : super(key: key);

  @override
  State<InicioEntrenador> createState() => _InicioEntrenadorState();
}

class _InicioEntrenadorState extends State<InicioEntrenador> {
  final Utils _utils = Utils();
  final WebProvider _webProvider = WebProvider();

  String nombreEntrenador = "";

  bool _isLoading = true;

  List _clientes = [];

  @override
  // ignore: must_call_super
  void initState() {
    String? nombreCompleto = prefs!.getString("nombreUsuario");
    List nombres = nombreCompleto!.split(" ");
    nombreEntrenador = nombres[0];

    String? idEntrenador = prefs!.getString("idUsuario");

    Map parametros = {"identrenador": idEntrenador};

    _webProvider.llamarFuncion("getClientes", parametros).then((value) {
      if (!value.contains("Error")) {
        _clientes = jsonDecode(value);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  //A PARTIR DE AHORA MOSTRAR LA LISTA DE CLIENTES CON UNA TARJETA, DONDE SE PODRA VER LA INFO PERSONAL, FECHA DE PAGO, POSIBILIDAD DE DAR DE BAJA,
  //VER SU RUTINA Y EDITARLA.

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
                child: Stack(children: [
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
                        Container(
                          margin: const EdgeInsets.only(left: 40),
                          child: Text(
                            "Bienvenido " + nombreEntrenador,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
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
                                children: [],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    }
  }
}
