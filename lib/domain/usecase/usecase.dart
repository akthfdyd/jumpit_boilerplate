/// {@category UseCase}
abstract class UseCase<T>{
  Future<T> perform(Map<String, dynamic> param);
}