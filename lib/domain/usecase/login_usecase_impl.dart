import 'package:jumpit_boilerplate/domain/entity/login_entity.dart';
import 'package:jumpit_boilerplate/domain/repository/login_repository.dart';
import 'package:jumpit_boilerplate/domain/usecase/usecase.dart';

/// {@category UseCase}
class LoginUseCaseImpl implements UseCase {
  LoginRepository loginRepository;

  LoginUseCaseImpl(this.loginRepository);

  @override
  Future perform(Map<String, dynamic> param) async {
    LoginEntity entity = await loginRepository.getLogin(param);
    return entity;
  }
}
