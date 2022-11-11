import 'dart:io';

import 'package:financas/model/usuario_autenticado.dart';
import 'package:financas/model/usuario_dto.dart';
import 'package:financas/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Resource<T> {
  final String url;
  final String path;
  T Function(http.Response response) parse;

  Resource({required this.url, required this.path, required this.parse});
}

class Webservice {
  final String token;

  Webservice({this.token = ''});

  Future<T> load<T>(Resource<T> resource) async {
    var url = Uri.parse('${resource.url}${resource.path}');
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    if (response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception('Erro ao carregar os dados!');
    }
  }

  Future<UsuarioAutenticado> attemptLogIn(
      String username, String password) async {
    var creds = UsuarioDTO(login: username, senha: password);
    var body = jsonEncode(creds);
    var url = Uri.parse('${Constants.restWebServiceURL}${Constants.loginPath}');
    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      return UsuarioAutenticado.fromJson(json.decode(response.body));
    }
    throw Exception('Erro no login!');
  }
}
