import 'package:designli/utils/api_utils.dart';
import 'package:designli/utils/load_status.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:designli/watchlist/domain/models/trade.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WatchlistProvider with ChangeNotifier {
  final channel = ValueNotifier<WebSocketChannel>(
    WebSocketChannel.connect(
      Uri.parse('wss://ws.finnhub.io?token=${ApiUtils.apiKey}'),
    ),
  );
  final throttleTimer = ValueNotifier<Timer?>(null);
  final progressTimer = ValueNotifier<Timer?>(null);
  final tradeDataList = ValueNotifier<List<TradeData>>([]);
  final latestData = ValueNotifier<List<TradeData>>([]);
  final progress = ValueNotifier<double>(0.0);
  final loadStatus = ValueNotifier<LoadStatus>(LoadStatus.init);
  final refreshInterval = ValueNotifier<int>(5);

  final dataPoints = ValueNotifier<List<FlSpot>>([]);
  double _time = 0;

  void init({required String symbol}) {
    loadStatus.value = LoadStatus.loading;
    notifyListeners();
    channel.value.sink.add(jsonEncode({
      'type': 'subscribe',
      'symbol': symbol,
    }));
    throttleTimer.value =
        Timer.periodic(Duration(seconds: refreshInterval.value), (timer) {
      tradeDataList.value = List.from(latestData.value);
      progress.value = 0.0;
      notifyListeners();
    });
    progressTimer.value =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      progress.value += 0.1 / refreshInterval.value;
      if (progress.value >= 1.0) {
        progress.value = 1.0;
      }
    });
  }

  void handleData(data) {
    final json = jsonDecode(data);
    if (json is Map<String, dynamic> && json['type'] == 'trade') {
      loadStatus.value = LoadStatus.complete;
      for (var item in json['data']) {
        _time += 1;
        dataPoints.value.add(FlSpot(_time, item['p']));
        if (dataPoints.value.length > 20) {
          dataPoints.value.removeAt(0);
        }
      }
    } else {
      loadStatus.value = LoadStatus.error;
    }
  }

  void disposer() {
    throttleTimer.value?.cancel();
    progressTimer.value?.cancel();
    channel.value.sink.close(status.goingAway);
    notifyListeners();
    super.dispose();
  }
}
