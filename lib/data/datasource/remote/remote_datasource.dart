import 'package:http/http.dart' as http;

enum HttpMethod { POST, PUT, GET, DELETE }

abstract class RemoteDataSource {
  Future<http.Response> request(
    HttpMethod httpMethod,
    String path,
    Map<String, dynamic> param,
  );
}