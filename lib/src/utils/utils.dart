import 'dart:convert';
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
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
