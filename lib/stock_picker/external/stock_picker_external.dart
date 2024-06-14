import 'dart:convert';
import 'package:designli/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'package:designli/stock_picker/domain/model/stock_model.dart';

class StockPickerExternal {
  Future<List<StockModel>?> fetchStocks() async {
    try {
      final response = await http.get(Uri.parse(
          'https://finnhub.io/api/v1/stock/symbol?exchange=US&token=${ApiUtils.apiKey}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final stocks = data.map((json) => StockModel.fromJson(json)).toList();
        return stocks;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
