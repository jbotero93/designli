// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trade _$TradeFromJson(Map<String, dynamic> json) => Trade(
      data: (json['data'] as List<dynamic>)
          .map((e) => TradeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$TradeToJson(Trade instance) => <String, dynamic>{
      'data': instance.data,
      'type': instance.type,
    };

TradeData _$TradeDataFromJson(Map<String, dynamic> json) => TradeData(
      p: (json['p'] as num).toDouble(),
      s: json['s'] as String,
      t: (json['t'] as num).toInt(),
      v: (json['v'] as num).toDouble(),
    );

Map<String, dynamic> _$TradeDataToJson(TradeData instance) => <String, dynamic>{
      'p': instance.p,
      's': instance.s,
      't': instance.t,
      'v': instance.v,
    };
