import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRepository {
  final String baseUrl = "http://localhost:4010";

  Future<dynamic> getData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      return jsonDecode(decodedBody);
    } else {
      throw Exception("Erro ao buscar dados: ${response.statusCode}");
    }
  }
}