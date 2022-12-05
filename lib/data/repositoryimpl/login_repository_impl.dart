import 'dart:convert';

import 'package:jumpit_boilerplate/data/datasource/local/api_url.dart';
import 'package:jumpit_boilerplate/data/datasource/remote/remote_datasource.dart';
import 'package:jumpit_boilerplate/data/model/response/login_post_vo.dart';
import 'package:jumpit_boilerplate/domain/entity/login_entity.dart';
import 'package:jumpit_boilerplate/domain/repository/login_repository.dart';

/// {@category RepositoryImpl}
class LoginRepositoryImpl implements LoginRepository {
  @override
  RemoteDataSource dataSource;

  LoginRepositoryImpl(this.dataSource);

  @override
  Future<LoginEntity> getLogin(Map<String, dynamic> param) async {
    var res = await dataSource.request(HttpMethod.POST, ApiUrl.LOGIN, param);

    var responseModel =
        LoginPostVO.fromJson(json.decode(utf8.decode(res.bodyBytes)));

    LoginEntity entity = LoginEntity(
      isSuccess: responseModel.status == 200,
      message: responseModel.message ?? "",
      accessToken: responseModel.data?.accessToken ?? "",
      refreshToken: responseModel.data?.refreshToken ?? "",
    );
    return entity;
  }
}
