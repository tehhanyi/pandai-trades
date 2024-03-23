import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varsity_app/api/secret.dart';

import '../models/stocks.dart';
import 'api.dart';

class LocalService {
  LocalService();

  Future<List<Stocks>> getAllStocks() async {
    final String response =  await rootBundle.loadString('assets/data/listed_stocks.json');
    var list = List<Stocks>.from(json.decode(response).map((data) => Stocks.fromJson(data)));
    // var c = a.where((m) => b.contains(m['id'])).map((m) => m['name']);
    list.shuffle();
    return list. sublist(0,50);
    // sharedPreferences.setString('watchlist', response.toString());
  }

  Future<Profile> getCompanyProfile(String symbol) async {
    print("https://finnhub.io/api/v1/stock/profile2?symbol=$symbol&token=$apiKey");
    var response = await Api().dio.get('/stock/profile2?symbol=$symbol&token=$apiKey');
    Map responseBody = response.data;
    print('getCompanyProfile\n$response');

    return Profile.fromJson(responseBody);
  }

  void addWatchlist() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String response =
    await rootBundle.loadString('assets/data/watchlist.json');

    sharedPreferences.setString('watchlist', response.toString());
  }

  Future<List<Stocks>> getAllWatchlist() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String? response =  sharedPreferences.getString('watchlist');
    if (response != null){

    }
    return [];
  }
}
