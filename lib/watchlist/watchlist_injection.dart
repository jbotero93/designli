import 'package:designli/watchlist/domain/watchlist_provider.dart';
import 'package:designli/watchlist/interface/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistInjection {
  WatchlistInjection._();

  static Widget injection(
      {required String symbol, required String valueAlert}) {
    return ListenableProvider(
      create: (context) => WatchlistProvider()..init(symbol: symbol),
      child: WatchlistScreen(),
    );
  }
}
