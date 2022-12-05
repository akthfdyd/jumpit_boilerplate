import 'dart:convert';

import 'package:http/http.dart';
import 'package:jumpit_boilerplate/data/datasource/remote/remote_datasource.dart';
import 'package:jumpit_boilerplate/data/datasource/local/api_url.dart';
import 'package:jumpit_boilerplate/data/datasource/local/mock_data_store.dart';
import 'package:jumpit_boilerplate/util/dev_log.dart';

/// {@category DataSource}
class MockHttpRequest implements RemoteDataSource {
  @override
  Future<Response> request(
      HttpMethod httpMethod, String path, Map<String, dynamic> param) async {
    Log.i("MockHttpRequest request >> ${ApiUrl.BASE_URL}$path");
    late String result;

    switch (path) {
      case ApiUrl.LOGIN:
        result = await getData("mockdata/post_login.json");
        break;
      default:
        Log.w("MockHttpRequest >>> no mock api for $path");
        break;
    }
    Response res = Response.bytes(utf8.encode(result), 200);
    Log.d("MockHttpRequest mock response >> ${res.body}");

    return res;
  }

  Future<String> getData(String path) async {
    return await MockDataStore.asset.loadString(path);
  }
}
