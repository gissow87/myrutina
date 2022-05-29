import 'dart:convert';

import 'package:http/http.dart' as http;

import 'utils.dart';

class WebProvider {
  final Utils _utils = Utils();

  Future<String> llamarFuncion(String funcion, Map mParametros) async {
    try {
      String parametros = _utils.base64Encode(jsonEncode(mParametros));
      var result = await http.post(
        Uri.parse('https://myrutina.sc3-app.com.ar/myrutina-api.php'),
        body: {
          'parametrosB64': parametros,
          'funcion': funcion,
        },
      );
      return result.body;
    } on Exception catch (exception) {
      return exception.toString();
    } catch (error) {
      return error.toString();
    }
  }
}
