import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varsity_app/api/secret.dart';
import 'package:http/http.dart' as http;

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

  Future<MarketInfo?> getMarketInfo(String symbol) async {
    var url = Uri.parse("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$vantageApiKey");
    var response = await http.get(url);
    Map responseBody = json.decode(response.body);
    if (responseBody['Information'] != null){
      print(responseBody['Information']);
      return null;
    }
    print('getMarketInfo ${response.body}');
    return MarketInfo.fromJson(responseBody['Global Quote']);
  }

  Future<bool> addWatchlist(Stocks stock) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    List<Stocks> list = await getAllWatchlist();
    list.add(stock);
    sharedPreferences.setString('watchlist', Stocks.encode(list));
    return true;
  }

  Future<bool> updateWatchlist(List<Stocks> stocks) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('watchlist', Stocks.encode(stocks));
    return true;
  }

  Future<List<Stocks>> getAllWatchlist() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String? response =  sharedPreferences.getString('watchlist');
    List<Stocks> list = [];
    if (response != '' && response != null){
      list = Stocks.decode(response);
    }
    return list;
  }
}
