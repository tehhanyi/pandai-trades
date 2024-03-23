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
  Profile? details;
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
    this.details,
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

  setCompanyDetails (Profile profile) => details = profile;
}

class Profile {
  final String country;
  final String? currency;
  final String industry;
  final String imagePath;
  final num marketCapitalisation;
  final num shareOutstanding;
  final String website;

  Profile({
    this.country = '',
    this.currency = '',
    this.industry = '',
    this.imagePath = '',
    this.marketCapitalisation = 0,
    this.shareOutstanding = 0,
    this.website ='www.example.com',
  });

  static fromJson(Map<dynamic, dynamic> json) {
    return Profile(
        country: json['country'].toString(),
        currency: json['currency'].toString(),
        industry: json['finnhubIndustry'].toString(),
        imagePath: json['logo'].toString() ,
        marketCapitalisation: json ['marketCapitalization'] ?? 0,
        shareOutstanding: json ['shareOutstanding'] ?? 0,
        website: json['weburl'] ?? ''
    );
  }
}
