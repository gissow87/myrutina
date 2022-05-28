import 'dart:convert';
import 'package:http/http.dart' as http;

import 'utils.dart';

class WebProvider {
  final Utils _utils = Utils();

  Future<String> llamarFuncion(String funcion, String jsonParametros) async {
    try {
      String parametros = _utils.base64Encode(jsonParametros);
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
