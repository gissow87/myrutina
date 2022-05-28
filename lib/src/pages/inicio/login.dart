import 'package:flutter/material.dart';

import '../../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _esEntrenador = false;
  bool _passwordVisible = false;

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
                )),
              ),
              SizedBox(
                height: size.height * 0.96,
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
                            children: [
                              TextField(
                                controller: _correo,
                                decoration: const InputDecoration(
                                  hintText: "Correo",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.4)),
                                ),
                              ),
                              const SizedBox(height: 25),
                              TextField(
                                controller: _password,
                                decoration: InputDecoration(
                                  hintText: "Contraseña",
                                  suffixIcon: _passwordVisible
                                      ? IconButton(
                                          icon: Icon(Icons.lock_open,
                                              color: Colors.teal[400]),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible = false;
                                            });
                                          })
                                      : IconButton(
                                          icon: Icon(Icons.lock_outline,
                                              color: Colors.teal[400]),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible = true;
                                            });
                                          }),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.4)),
                                ),
                                obscureText: _passwordVisible,
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      checkColor: Colors.teal[400],
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor),
                                      value: _esEntrenador,
                                      onChanged: (value) {
                                        setState(() {
                                          _esEntrenador = value ?? false;
                                        });
                                      }),
                                  const Text("Soy entrenador",
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              const SizedBox(height: 25),
                              const Text("¿Aún no tienes cuenta?",
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 25),
                              InkWell(
                                child: Text("Registrate aquí",
                                    style: TextStyle(
                                        color: Colors.tealAccent[400])),
                                onTap: () {
                                  Navigator.pushNamed(context, "register_page");
                                },
                              ),
                              const SizedBox(height: 25),
                              ElevatedButton(
                                child: const Text(
                                  "Iniciar sesión",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                              ),
                              const SizedBox(height: 25),
                              InkWell(
                                child: Text(
                                    "¿Olvidaste tu contraseña?\r\nToca aquí para recuperarla.",
                                    style: TextStyle(
                                        color: Colors.tealAccent[400])),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "recuperar_clave");
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
    ));
  }
}
