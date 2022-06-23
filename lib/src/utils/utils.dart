import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class Utils {
  String base64Encode(String texto) {
    String encoded = base64.encode(utf8.encode(texto));
    return encoded;
  }

  String base64Decode(String texto) {
    String decoded = utf8.decode(base64.decode(texto));
    return decoded;
  }

  String md5Encode(String texto) {
    return md5.convert(utf8.encode(texto)).toString();
  }

  Widget logoPage(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: ((context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Image(image: AssetImage("assets/icons/logo.png")),
                ),
                SizedBox(height: constraints.maxHeight * 0.1),
                CircularProgressIndicator(
                  color: Colors.teal[300],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  String randomCodigo() {
    List codigo = [];
    Random ran = Random();
    for (int i = 0; i < 8; i++) {
      var n = ran.nextInt(9);
      codigo.add(n);
    }
    return codigo.join("");
  }

// ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables

}
