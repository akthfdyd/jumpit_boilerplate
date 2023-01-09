import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jumpit_boilerplate/main.dart' as app;
import 'package:jumpit_boilerplate/presentation/screen/login/login_view.dart';

void main() {
  group('ui_test_auto_login', () {
    testWidgets('자동로그인 테스트', (tester) async {
      app.main();
      String logStr = "";

      // section: wait launch
      logStr = "첫화면 my탭 노출 확인";
      log(logStr, false);
      await tester.pumpAndSettle();
      expectWidgetRender('bottomTabMy');
      log(logStr, true);

      // section: go signin screen
      logStr = "my탭을 눌러 로그인화면 노출 확인";
      log(logStr, false);
      await tester.pumpAndSettle();
      await tester.tap(findByKey('bottomTabMy'));
      await tester.pumpAndSettle();
      expectWidgetRender('textFieldLoginID');
      log(logStr, true);

      LoginScreenState loginScreenState =
          tester.state(find.byType(LoginScreen));

      // section: input id
      logStr = "ID 입력 확인";
      log(logStr, false);
      await tester.pumpAndSettle();
      await tester.tap(findByKey('textFieldLoginID'));
      await tester.pumpAndSettle();
      await tester.enterText(findByKey('textFieldLoginID'), "test@test.com");
      await tester.pumpAndSettle();
      expect(loginScreenState.loginViewModel.idText.val, "test@test.com");
      log(logStr, true);

      // section: input wrong pw
      logStr = "PW 입력 확인";
      log(logStr, false);
      await tester.pumpAndSettle();
      await tester.tap(findByKey('textFieldLoginPW'));
      await tester.pumpAndSettle();
      await tester.enterText(findByKey('textFieldLoginPW'), "1234qwe");
      await tester.pumpAndSettle();
      expect(loginScreenState.loginViewModel.pwText.val, "1234qwe");
      log(logStr, true);

      // section: pw obscure state
      logStr = "PW 숨김처리 체크";
      log(logStr, false);
      TextField textFieldLoginPW = tester.widget(findByKey('textFieldLoginPW'));
      expect(textFieldLoginPW.obscureText, true);
      log(logStr, true);

      // section: wrong pw validation
      logStr = "PW 입력 검증";
      log(logStr, false);
      Text textValidationPW = tester.widget(findByKey("textValidationPW"));
      expect(textValidationPW.data, "at least 8 characters");
      log(logStr, true);

      // section: input correct pw
      logStr = "제대로 입력된 PW 입력 확인";
      log(logStr, false);
      await tester.pumpAndSettle();
      await tester.tap(findByKey('textFieldLoginPW'));
      await tester.pumpAndSettle();
      await tester.enterText(findByKey('textFieldLoginPW'), "1234qwer");
      await tester.pumpAndSettle();
      expect(loginScreenState.loginViewModel.pwText.val, "1234qwer");
      log(logStr, true);

      // section: correct pw validation
      logStr = "PW 입력 검증";
      log(logStr, false);
      textValidationPW = tester.widget(findByKey("textValidationPW"));
      expect(textValidationPW.data, "good password");
      log(logStr, true);

      // section: tap sign in button and go home
      logStr = "sign in 후 홈으로 이동";
      log(logStr, false);
      await tester.tap(findByKey('buttonSignIn'));
      await tester.pumpAndSettle();
      expectWidgetRender('textHome');
      log(logStr, true);
    });
  });
}

void log(String msg, bool isFinished) {
  print(
      '------------------ UI 테스트 ${isFinished ? "성공" : "시작"} => $msg  ------------------');
  if (isFinished) print('');
}

void expectWidgetRender(String key) {
  expect(findByKey(key), findsOneWidget);
}

Finder findByKey(String key) {
  return find.byKey(Key(key));
}
