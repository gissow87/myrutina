import 'package:flutter/material.dart';

import '../../../main.dart';

class InicioEntrenador extends StatefulWidget {
  const InicioEntrenador({Key? key}) : super(key: key);

  @override
  State<InicioEntrenador> createState() => _InicioEntrenadorState();
}

class _InicioEntrenadorState extends State<InicioEntrenador> {
  @override
  Widget build(BuildContext context) {
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
                        child: const Text(
                          "Bienvenido Pepito",
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
