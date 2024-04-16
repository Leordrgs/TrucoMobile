import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<dynamic> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      // JSON, decodificá-lo aqui
      return response.body;
    } else {
      throw Exception('Falha ao carregar dados da API');
    }
  }

  // Outros métodos para post, put, delete, etc.
}
