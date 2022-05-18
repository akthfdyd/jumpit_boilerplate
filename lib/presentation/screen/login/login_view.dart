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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              false,
              "ID",
              "ex) mad@formad.com",
              loginViewModel.onChangedId,
            ),
            const SizedBox(height: 30),
            buildCommonTextField(
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
          // passwordValidation(pw.hasData ? pw.data ?? "" : ""),
          passwordValidation("${loginViewModel.pwText.val}"),
          style: const TextStyle(color: Color(0xffff5555)),
        ),
      ),
    );
  }

  Widget buildSignInButton() {
    return InkWell(
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
