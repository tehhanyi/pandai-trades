part of 'watchlist_bloc.dart';

enum WatchListStatus { initial, success, error, loading, cardLoading, cardLoaded }

extension WatchListStatusX on WatchListStatus {
  bool get isInitial => this == WatchListStatus.initial;
  bool get isSuccess => this == WatchListStatus.success;
  bool get isError => this == WatchListStatus.error;
  bool get isLoading => this == WatchListStatus.loading;
  bool get isDetailsLoading => this == WatchListStatus.cardLoading;
  bool get isDetailsLoaded => this == WatchListStatus.cardLoaded;

// bool get isDataChange => this == FoodCartStatus.dataChange;
  // bool get isMerchantChange => this == FoodCartStatus.merchantChange;
}

class WatchListState extends Equatable {
  final List<Stocks> watchlist;
  final List<Stocks> others;
  final WatchListStatus status;

  // final FoodCartItem? pendingFoodCartItem;
  // final num? deductedBalance;
  // final num totalDeductedPoints;

  WatchListState({
    this.status = WatchListStatus.initial,
    List<Stocks>? watchlist,
    List<Stocks>? others,
    // this.pendingFoodCartItem,
    // this.deductedBalance,
    // this.totalDeductedPoints = 0,
  }) : watchlist = watchlist ?? [], others = others ?? [];

  @override
  List<Object?> get props => [status, watchlist, others];

  WatchListState copyWith({
    WatchListStatus? status,
    List<Stocks>? watchlist,
    List<Stocks>? others,
  }) {
    return WatchListState(
        status: status ?? this.status,
        watchlist: watchlist ?? this.watchlist,
        others: others ?? this.others,
        // matchEngine: matchEngine ?? this.matchEngine
        // pendingFoodCartItem: pendingFoodCartItem ?? this.pendingFoodCartItem,
        // // deductedBalance: deductedBalance ?? this.deductedBalance,
        // totalDeductedPoints: totalDeductedPoints ?? this.totalDeductedPoints
    );
  }
}
