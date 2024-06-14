import 'package:designli/login/login_injection.dart';
import 'package:designli/utils/designli_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: DesignliColors.magent),
        iconTheme: const IconThemeData(color: Colors.white),
        useMaterial3: true,
      ),
      home: LoginInjection.injection(),
    );
  }
}
