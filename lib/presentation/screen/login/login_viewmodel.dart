import 'package:arc/arc_subject.dart';
import 'package:jumpit_boilerplate/data/datasource/local/temporary_data.dart';
import 'package:jumpit_boilerplate/domain/entity/login_entity.dart';
import 'package:jumpit_boilerplate/domain/usecase/login_usecase_impl.dart';
import 'package:jumpit_boilerplate/domain/usecase/usecase.dart';
import 'package:jumpit_boilerplate/injection_container.dart';
import 'package:jumpit_boilerplate/presentation/viewmodel_interface.dart';
import 'package:jumpit_boilerplate/util/dev_log.dart';

enum LoginViewState { START, LOGIN_COMPLETED, LOGIN_ERROR, LOGIN_FAILED }

class LoginViewModel implements ViewModelInterface {
  // section: view state
  final viewState = ArcSubject<LoginViewState>();

  @override
  void loadState(state) {
    Log.i("LoginViewModel loadState $state");
    state = state as LoginViewState;
    viewState.val = state;
  }

  @override
  disposeAll() {
    Log.i("LoginViewModel disposeAll");
    viewState.close();
  }

  // section: autologin switch
  var isAutoLogin = true.sbj;

  onToggleAutoLogin() => isAutoLogin.val = !isAutoLogin.val;

  // section: textfiled input
  var idText = "".sbj;

  onChangedId(String str) => idText.val = str;

  var pwText = "".sbj;

  onChangedPw(String str) => pwText.val = str;

  // section: sign in
  UseCase signInUseCase = it<LoginUseCaseImpl>();

  signIn() async {
    Log.i("LoginViewModel signIn");
    Map<String, dynamic> param = {};
    param['id'] = idText.val;
    param['pw'] = pwText.val;
    try {
      LoginEntity result = await signInUseCase.perform(param);

      if (result.isSuccess) {
        result.refreshToken.sbj.save("refreshToken");
        result.accessToken.sbj.save("accessToken")?.then((isSuccess) {
          if (isSuccess) {
            TemporaryData.isLogin = true;
            loadState(LoginViewState.LOGIN_COMPLETED);
          } else {
            loadState(LoginViewState.LOGIN_ERROR);
            Log.w("LoginViewModel signIn >>> get login error on save token");
          }
        });
      } else {
        loadState(LoginViewState.LOGIN_ERROR);
        Log.w("LoginViewModel signIn >>> get login error from api");
      }
    } catch (error, stack) {
      loadState(LoginViewState.LOGIN_FAILED);
      Log.e(error, stack);
    }
  }
}