import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:jumpit_boilerplate/data/datasource/remote/remote_datasource.dart';
import 'package:jumpit_boilerplate/data/datasource/local/api_url.dart';
import 'package:jumpit_boilerplate/data/datasource/local/constant.dart';
import 'package:jumpit_boilerplate/util/dev_log.dart';

/// {@category DataSource}
class HttpRequest implements RemoteDataSource {
  @override
  Future<Response> request(
      HttpMethod httpMethod, String path, Map<String, dynamic> param) async {
    Map<String, String> header;
    header = {"Content-Type": "application/json"};

    late http.Response res;
    try {
      switch (httpMethod) {
        case HttpMethod.POST:
          res = await postRequest(path, param, header);
          break;
        case HttpMethod.PUT:
          res = await putRequest(path, param, header);
          break;
        case HttpMethod.GET:
          res = await getRequest(path, param, header);
          break;
        case HttpMethod.DELETE:
          res = await deleteRequest(path, param, header);
          break;
      }
      Log.d("http_log responseHeader << $path ${res.headers}");
      Log.d("http_log responseBody << $path ${utf8.decode(res.bodyBytes)}");

      return requestTail(
        httpMethod,
        res,
        path,
        param,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<http.Response> postRequest(
      String path, Map<String, dynamic> param, Map<String, String> header) {
    Log.v("postRequest");
    String bodyJson = "";
    try {
      bodyJson = json.encode(param);
      Log.v("postRequest bodyJson $bodyJson");
    } catch (error, stacktrace) {
      Log.e(error, stacktrace,
          text: "HttpRequest postRequest parameter json encode failed");
    }
    try {
      HttpClient httpClient = HttpClient();
      setProxy(httpClient);
      IOClient ioClient = IOClient(httpClient);
      return ioClient.post(
        Uri.parse(ApiUrl.BASE_URL + path),
        body: bodyJson,
        headers: header,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<http.Response> putRequest(
      String path, Map<String, dynamic> param, Map<String, String> header) {
    Log.i("HttpRequest putRequest");
    String? bodyJson;
    try {
      bodyJson = json.encode(param);
    } catch (error, stacktrace) {
      Log.e(error, stacktrace,
          text: "HttpRequest putRequest parameter json encode failed");
    }
    Log.v("putRequest bodyJson $bodyJson");
    try {
      HttpClient httpClient = HttpClient();
      setProxy(httpClient);
      IOClient ioClient = IOClient(httpClient);
      return ioClient.put(
        Uri.parse(ApiUrl.BASE_URL + path),
        body: bodyJson,
        headers: header,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<http.Response> getRequest(
      String path, Map<String, dynamic> param, Map<String, String> header) {
    Log.i("HttpRequest getRequest");
    try {
      var url = ApiUrl.BASE_URL + path + Uri(queryParameters: param).toString();
      Log.v("http_log getRequest $url");

      HttpClient httpClient = HttpClient();
      setProxy(httpClient);
      IOClient ioClient = IOClient(httpClient);

      return ioClient.get(
        Uri.parse(url),
        headers: header,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<http.Response> deleteRequest(
      String path, Map<String, dynamic> param, Map<String, String> header) {
    Log.i("HttpRequest deleteRequest");
    try {
      var url = ApiUrl.BASE_URL + path + Uri(queryParameters: param).toString();
      Log.v("http_log deleteRequest $url");

      HttpClient httpClient = HttpClient();
      setProxy(httpClient);
      IOClient ioClient = IOClient(httpClient);

      return ioClient.delete(
        Uri.parse(url),
        headers: header,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<http.Response> requestTail(
    HttpMethod httpMethod,
    http.Response res,
    String path,
    Map<String, dynamic> param,
  ) async {
    Log.i("HttpRequest requestTail $path");
    Log.d("HttpRequest requestTail res.statusCode == ${res.statusCode}");
    if (res.statusCode == 401) {
      throw Exception("HttpRequest requestTail 401 error");
    } else if (res.statusCode ~/ 100 == 2) {
      return res;
    } else if (res.statusCode ~/ 100 == 3) {
      throw Exception("HttpRequest requestTail 3xx error");
    } else if (res.statusCode ~/ 100 == 4) {
      throw Exception("HttpRequest requestTail 4xx error");
    } else if (res.statusCode ~/ 100 == 5) {
      throw Exception("HttpRequest requestTail 5xx error");
    } else {
      throw Exception("HttpRequest requestTail etc error");
    }
  }

  void setProxy(HttpClient httpClient) {
    if (Const.useProxy && !kReleaseMode) {
      String proxy = Const.proxyAddress;
      httpClient.findProxy = (uri) {
        return "PROXY $proxy;";
      };
      httpClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) {
        return true;
      });
    }
  }
}
