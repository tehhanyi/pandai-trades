// import 'package:equatable/equatable.dart';

import 'dart:ui';

import 'package:flutter/material.dart';

class Stocks {
  final String symbol;
  final String? name;
  final String exchange;
  final String assetType;
  final DateTime ipoDate;
  final Color? color;
  // final DateTime? delisting;
  bool swiped;


  Stocks({
    required this.symbol,
    this.name,
    required this.exchange,
    required this.assetType,
    required this.ipoDate,
    // this.delisting,
    required this.swiped,
    required this.color,
  });

  static fromJson(Map<String, dynamic> json) {
    return Stocks(
        symbol: json['symbol'],
        name: json['name'],
        exchange: json['exchange'],
        assetType: json['assetType'],
        ipoDate: DateTime.parse(json['ipoDate']) ,
        swiped: json['swiped'] == 0? false: true,
        color: json['assetType'] == 'Stock' ? Colors.red[50] : Colors.blue[50]
    );
  }
}
