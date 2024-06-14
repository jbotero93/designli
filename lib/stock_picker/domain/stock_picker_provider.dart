import 'package:designli/stock_picker/domain/model/stock_model.dart';
import 'package:designli/stock_picker/external/stock_picker_external.dart';
import 'package:designli/utils/designli_colors.dart';
import 'package:designli/utils/load_status.dart';
import 'package:designli/watchlist/watchlist_injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockPickerProvider with ChangeNotifier {
  final stockLoad = ValueNotifier<LoadStatus>(LoadStatus.init);
  final stocks = ValueNotifier<List<StockModel>>([]);
  final filteredStocks = ValueNotifier<List<StockModel>>([]);
  final selectedStock = ValueNotifier<StockModel?>(null);
  final stockFieldController =
      ValueNotifier<TextEditingController>(TextEditingController());
  final valueFieldController =
      ValueNotifier<TextEditingController>(TextEditingController());
  final useField = ValueNotifier<bool>(false);

  void filterStocks() {
    final query = stockFieldController.value.text.toLowerCase();
    filteredStocks.value = stocks.value.where((stock) {
      return stock.symbol.toLowerCase().contains(query);
    }).toList();
    notifyListeners();
  }

  String? validateDollarAmount(String value) {
    const pattern = r'^\d+(\.\d{1,2})?$';
    final regExp = RegExp(pattern);

    if (value.isEmpty) {
      return 'Please enter an amount';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid dollar amount';
    }
    return null;
  }

  void validateAndNavigate(BuildContext context) {
    if (validateDollarAmount(valueFieldController.value.text) == null &&
        selectedStock.value != null) {
      // Get.to(
      //   () => WatchlistInjection.injection(
      //     symbol: selectedStock.value!.symbol,
      //     valueAlert: valueFieldController.value.text,
      //   ),
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WatchlistInjection.injection(
            symbol: selectedStock.value!.symbol,
            valueAlert: valueFieldController.value.text,
          ),
        ),
      );
    } else if (validateDollarAmount(valueFieldController.value.text) == null &&
        selectedStock.value == null) {
      Get.snackbar(
        'Hey!',
        'You need to select a stock to proceed',
        backgroundColor: Colors.white,
        colorText: DesignliColors.blueBackground,
      );
    } else if (validateDollarAmount(valueFieldController.value.text) != null &&
        selectedStock.value != null) {
      Get.snackbar(
        'Hey!',
        validateDollarAmount(valueFieldController.value.text)!,
        backgroundColor: Colors.white,
        colorText: DesignliColors.blueBackground,
      );
    } else if (validateDollarAmount(valueFieldController.value.text) != null &&
        selectedStock.value == null) {
      Get.snackbar(
        'Hey!',
        'Did you even read it???????',
        backgroundColor: Colors.white,
        colorText: DesignliColors.blueBackground,
      );
    } else {
      Get.snackbar(
        'Hey!',
        'My bad',
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
    }
  }

  void pickStock({required StockModel? stock}) {
    selectedStock.value = stock;
    notifyListeners();
  }

  Future<void> fetchStocks() async {
    stockLoad.value = LoadStatus.loading;
    notifyListeners();
    final stockValidator = await StockPickerExternal().fetchStocks();
    if (stockValidator != null) {
      stockLoad.value = LoadStatus.complete;
      stocks.value = stockValidator;
      filteredStocks.value = stockValidator;
    } else {
      stockLoad.value = LoadStatus.error;
    }
    notifyListeners();
  }
}
