import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pethelper/Screen/myPetScreen.dart';
import 'package:pethelper/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('registering user test', () {
    testWidgets('registering user with an account',
        (WidgetTester tester) async {
      app.main();

      //getting to sign up
      await tester.pumpAndSettle(const Duration(seconds: 3));
      var registerwithoutpetButton =
          find.byKey(const Key('registerwithoutpetButton'));
      await tester.tap(registerwithoutpetButton);
      //got to sign up
      await tester.pumpAndSettle(const Duration(seconds: 3));
      var firstName = find.byKey(const Key('firstName'));
      await tester.tap(firstName);
      await tester.enterText(firstName, "Testing");

      await tester.pumpAndSettle(const Duration(seconds: 3));
      var lastName = find.byKey(const Key('lastName'));
      await tester.tap(lastName);
      await tester.enterText(lastName, "Testing");

      await tester.pumpAndSettle(const Duration(seconds: 3));
      var email = find.byKey(const Key('email'));
      await tester.tap(email);
      await tester.enterText(email, "TestingBot@test.com");

      await tester.pumpAndSettle(const Duration(seconds: 3));
      var password = find.byKey(const Key('password'));
      await tester.tap(password);
      await tester.enterText(password, "password");

      await tester.pumpAndSettle(const Duration(seconds: 3));
      var password2 = find.byKey(const Key('password2'));
      await tester.tap(password2);
      await tester.enterText(password2, "password");

      await tester.pumpAndSettle(const Duration(seconds: 3));
      var gdprButton = find.byKey(const Key('gdprButton'));
      await tester.tap(gdprButton);

      await tester.pumpAndSettle(const Duration(seconds: 5));
      var gdprBack = find.byKey(const Key('gdprBack'));
      await tester.tap(gdprBack);

      await tester.pumpAndSettle(const Duration(seconds: 5));
      var signup = find.byKey(const Key('signup'));
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });
  });
}
