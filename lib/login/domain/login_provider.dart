import 'package:designli/stock_picker/stock_picker_injection.dart';
import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:get/get.dart';

class LoginProvider with ChangeNotifier {
  final isLoading = ValueNotifier<bool>(false);
  final appScheme = 'designli';

  late Auth0 auth0;

  Future<void> setupAuth0() async {
    auth0 = Auth0('dev-hnbc1f5dyxsbj3io.us.auth0.com',
        'xUfrehF7Zd9suNDXCRzOWM9n3bZ1RsbK');
  }

  Future<Credentials?> loginAction() async {
    isLoading.value = true;
    notifyListeners();
    try {
      final Credentials credentials =
          await auth0.webAuthentication(scheme: appScheme).login();
      isLoading.value = false;

      notifyListeners();

      Get.offAll(() => StockPickerInjection.injection());
      return credentials;
    } on Exception {
      isLoading.value = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> logoutAction() async {
    await auth0.webAuthentication(scheme: appScheme).logout();
  }
}
