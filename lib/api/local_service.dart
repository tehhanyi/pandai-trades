import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  LocalService();

  void addWatchlist() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final String response =
    await rootBundle.loadString('assets/data/watchlist.json');

    sharedPreferences.setString('watchlist', response.toString());
  }

}
