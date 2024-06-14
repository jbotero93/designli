class StockModel {
  final String currency;
  final String description;
  final String displaySymbol;
  final String figi;
  final String mic;
  final String symbol;
  final String type;

  StockModel({
    required this.currency,
    required this.description,
    required this.displaySymbol,
    required this.figi,
    required this.mic,
    required this.symbol,
    required this.type,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      currency: json['currency'],
      description: json['description'],
      displaySymbol: json['displaySymbol'],
      figi: json['figi'],
      mic: json['mic'],
      symbol: json['symbol'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'description': description,
      'displaySymbol': displaySymbol,
      'figi': figi,
      'mic': mic,
      'symbol': symbol,
      'type': type,
    };
  }
}
