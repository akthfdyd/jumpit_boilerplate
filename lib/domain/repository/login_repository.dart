import 'package:jumpit_boilerplate/data/datasource/remote/remote_datasource.dart';
import 'package:jumpit_boilerplate/domain/entity/login_entity.dart';

abstract class LoginRepository {
  RemoteDataSource dataSource;

  LoginRepository(this.dataSource);

  Future<LoginEntity> getLogin(Map<String, dynamic> param);
}