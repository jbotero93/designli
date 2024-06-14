import 'package:designli/login/domain/login_provider.dart';
import 'package:designli/login/interface/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginInjection {
  LoginInjection._();

  static Widget injection() {
    return ListenableProvider(
      create: (context) => LoginProvider()..setupAuth0(),
      child: const LoginScreen(),
    );
  }
}
