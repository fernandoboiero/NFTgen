import 'dart:convert';

import 'package:http/http.dart';

abstract class GraphQlServiceBase {
  Future<Map<String, dynamic>> query(String query, Map vars);

  Future<Map<String, dynamic>> mutation(String query, Map vars);
}

class GraphQlService extends GraphQlServiceBase {
  final Client client;
  final String host;

  GraphQlService({required this.host, required this.client});

  Future<String> getToken() async {
    // try {
    //   final string =
    //       (await SharedPreferences.getInstance()).getString('session') ?? '';
    //   final result = SessionModel.fromJson(json.decode(string));
    //   return "Bearer ${result.token}";
    // } catch (e) {
    return '';
    // }
  }

  @override
  Future<Map<String, dynamic>> query(String query, Map vars) async {
    Map<String, dynamic> body = {
      "query": "query $query",
      "variables": vars,
    };
    var response = await client.post(
      Uri.parse(host),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Authorization": await getToken()
      },
    );
    checkStatusCode(response);
    return json.decode(response.body);
  }

  @override
  Future<Map<String, dynamic>> mutation(String query, Map vars) async {
    Map<String, dynamic> body = {"query": "mutation $query", "variables": vars};
    var response = await client.post(
      Uri.parse(host),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Authorization": await getToken()
      },
    );
    checkStatusCode(response);
    return json.decode(response.body);
  }



  checkStatusCode(Response response) {
    print(response.statusCode);
    // print(response.body);

    // if (response.statusCode == 401) {
    //   throw UnhandledFailure(message: 'Unauthorized 401');
    // }
    // if (response.statusCode == 500) {
    //   throw UnhandledFailure(message: 'Error desconocido code:500');
    // }
    // final body = jsonDecode(response.body) as Map<String, dynamic>;
    // if (body['errors'] != null)
    //   throw UnhandledFailure(message: body['errors'][0]['message']);
  }
}
