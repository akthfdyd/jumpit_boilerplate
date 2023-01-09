import 'dart:ui';

import 'package:arc/arc.dart';
import 'package:flutter/material.dart';
import 'package:jumpit_boilerplate/injection_container.dart';
import 'package:jumpit_boilerplate/presentation/component/common_textfield.dart';
import 'package:jumpit_boilerplate/presentation/component/custom_switch.dart';
import 'package:jumpit_boilerplate/presentation/helper/text_validation.dart';
import 'package:jumpit_boilerplate/presentation/screen/login/login_viewmodel.dart';
import 'package:jumpit_boilerplate/util/dev_log.dart';
import 'package:jumpit_boilerplate/util/screen_util.dart';

/// {@category Screen}
/// 로그인 화면 [LoginScreenState]
/// - Project: http://www.groupware.com/projectnumber
/// - Design: http://www.designaddress.com/projectnumber
/// - Specification: http://www.specandwireframe.com/projectnumber
/// ***
/// # Dev TC
/// #### [o] ID 란에 이메일 주소 입력이 되는가
/// #### [x] ID 입력조건(xxx@xxx.xxx 이메일 주소 형태)에 따라 Validation이 되는가
/// #### [o] PW 란에 비밀번호 입력이 되는가
/// #### [o] PW를 입력할 때 숨김처리가 되는가
/// #### [o] PW 입력조건(8자 이상)에 맞지 않는 경우 에러메세지가 노출되는가
/// #### [o] Sign in 버튼을 눌러 로그인 처리가 되고 이전 화면으로 돌아가는가
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  // explain: View should be passive. ViewModel has business logic.
  var loginViewModel = it<LoginViewModel>();

  @override
  void initState() {
    Log.i("LoginScreen initState");
    loginViewModel.viewState.stream.listen((event) {
      switch (event) {
        case LoginViewState.START:
          break;
        case LoginViewState.LOGIN_COMPLETED:
          Arc.pop(result: "complete");
          break;
        case LoginViewState.LOGIN_ERROR:
          showDialog(
              context: Arc().currentContext,
              builder: (context) {
                return const Text(
                    "login error,\nplaease check your id/password.");
              });
          break;
        case LoginViewState.LOGIN_FAILED:
          showDialog(
              context: Arc().currentContext,
              builder: (context) {
                return const Text("login failed,\nplaease try again.");
              });
          break;
      }
    });
    loginViewModel.loadState(LoginViewState.START);
    super.initState();
  }

  @override
  void dispose() {
    Log.i("LoginScreen dispose");
    loginViewModel.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcccccc),
      body: Container(
        width: getScreenWidth(context),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 100),
            buildCommonTextField(
              const Key("textFieldLoginID"),
              false,
              "ID",
              "ex) mad@formad.com",
              loginViewModel.onChangedId,
            ),
            const SizedBox(height: 30),
            buildCommonTextField(
              const Key("textFieldLoginPW"),
              true,
              "Password",
              "at least 8 characters",
              loginViewModel.onChangedPw,
            ),
            buildValidationText(context),
            const SizedBox(height: 10),
            buildAutologinSwitch(),
            const SizedBox(height: 100),
            buildSignInButton()
          ],
        ),
      ),
    );
  }

  Widget buildAutologinSwitch() {
    return Row(
      children: [
        loginViewModel.isAutoLogin.ui(
            builder: (context, autoLogin) => CustomSwitch(
                value: autoLogin.data ?? false,
                onChanged: (value) {
                  loginViewModel.onToggleAutoLogin();
                })),
        const SizedBox(width: 6),
        const Text("auto login"),
      ],
    );
  }

  Widget buildValidationText(BuildContext context) {
    return SizedBox(
      width: getScreenWidth(context),
      child: loginViewModel.pwText.ui(
        builder: (context, pw) => Text(
          passwordValidation("${loginViewModel.pwText.val}"),
          key: const Key("textValidationPW"),
          style: const TextStyle(color: Color(0xffff5555)),
        ),
      ),
    );
  }

  Widget buildSignInButton() {
    return InkWell(
      key: const Key("buttonSignIn"),
      onTap: () {
        loginViewModel.signIn();
      },
      child: Container(
        color: const Color(0xffccaacc),
        width: 150,
        height: 50,
        child: const Center(child: Text("SIGN IN")),
      ),
    );
  }
}
