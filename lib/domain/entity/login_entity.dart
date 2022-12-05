// explain: Useful data in presentation layer (UI/UX designer knows this data)

/// {@category Entity}
/// When data structure is very complicated,
/// you can write entity as an abstract class, and VO should implement it.
class LoginEntity {
  bool isSuccess;
  String message;
  String accessToken;
  String refreshToken;

  LoginEntity({
    required this.isSuccess,
    required this.message,
    required this.accessToken,
    required this.refreshToken,
  });
}
