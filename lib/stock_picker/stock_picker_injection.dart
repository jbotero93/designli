import 'package:designli/stock_picker/domain/stock_picker_provider.dart';
import 'package:designli/stock_picker/interface/stock_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockPickerInjection {
  StockPickerInjection._();

  static Widget injection() {
    return ListenableProvider(
      create: (context) => StockPickerProvider()..fetchStocks(),
      child: const StockPickerScreen(),
    );
  }
}
