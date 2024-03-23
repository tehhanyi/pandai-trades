import '../models/stocks.dart';
import 'local_service.dart';

class LocalRepository {
  const LocalRepository({
    required this.service,
  });
  final LocalService service;

  Future<List<Stocks>> getAllStocks() async => service.getAllStocks();

  Future<Profile> getCompanyProfile(String symbol) async => service.getCompanyProfile(symbol);

  Future<List<Stocks>> getAllWatchlist() async => service.getAllWatchlist();

}
