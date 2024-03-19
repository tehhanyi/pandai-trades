import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/stocks.dart';

class LocalService {
  LocalService();

  void addWatchlist() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String response =
    await rootBundle.loadString('assets/data/watchlist.json');

    sharedPreferences.setString('watchlist', response.toString());
  }

  Future<List<Stocks>> getAllStocks() async {
    final String response =  await rootBundle.loadString('assets/data/listed_stocks.json');
    var list = List<Stocks>.from(json.decode(response).map((data) => Stocks.fromJson(data)));
    // var c = a.where((m) => b.contains(m['id'])).map((m) => m['name']);
    list.shuffle();
    print (list. sublist(0,50));
    return list. sublist(0,50);
    // sharedPreferences.setString('watchlist', response.toString());
  }

}
