import 'package:json_annotation/json_annotation.dart';

part 'trade.g.dart';

@JsonSerializable()
class Trade {
  final List<TradeData> data;
  final String type;

  Trade({required this.data, required this.type});

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);
  Map<String, dynamic> toJson() => _$TradeToJson(this);
}

@JsonSerializable()
class TradeData {
  final double p;
  final String s;
  final int t;
  final double v;

  TradeData(
      {required this.p, required this.s, required this.t, required this.v});

  factory TradeData.fromJson(Map<String, dynamic> json) =>
      _$TradeDataFromJson(json);
  Map<String, dynamic> toJson() => _$TradeDataToJson(this);
}
