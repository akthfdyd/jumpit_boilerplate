/// {@category DataSource}
class TemporaryData {
  static final TemporaryData _instance = TemporaryData._internal();

  factory TemporaryData() {
    return _instance;
  }

  TemporaryData._internal();

  static bool isLogin = false;
}
