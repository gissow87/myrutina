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
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Theme(
        data: themeData,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(children: [
              Container(
                height: size.height * 0.97,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/login.jpg"),
                  fit: BoxFit.cover,
                )),
              ),
              SizedBox(
                height: size.height * 0.96,
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
    );
  }
}
