import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jumpit_boilerplate/main.dart' as app;

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

      // section: input id/pw and signin
      logStr = "ID/PW입력 후 sign in 버튼 클릭하여 홈으로 돌아왔는지 확인";
      log(logStr, false);
      await tester.pumpAndSettle();
      await tester.tap(findByKey('textFieldLoginID'));
      await tester.pumpAndSettle();
      await tester.enterText(findByKey('textFieldLoginID'), "test@test.com");
      await tester.pumpAndSettle();
      await tester.tap(findByKey('textFieldLoginPW'));
      await tester.pumpAndSettle();
      await tester.enterText(findByKey('textFieldLoginPW'), "1234qwer");
      await tester.pumpAndSettle();
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
