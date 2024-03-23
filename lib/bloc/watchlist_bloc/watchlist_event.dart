part of 'watchlist_bloc.dart';

abstract class WatchListEvent extends Equatable {
  const WatchListEvent();
}

class GetAllItemsItems extends WatchListEvent {
  @override
  List<Object?> get props => [];
}

class AddWatchList extends WatchListEvent {
  final Stocks item;

  const AddWatchList(this.item);

  @override
  List<Object?> get props => [];
}

class RemoveWatchList extends WatchListEvent {
  final Stocks item;

  const RemoveWatchList(this.item);

  @override
  List<Object?> get props => [];
}


// class GetMoreInfo extends WatchListEvent {
//   // final Stocks currentItem;
//
//   // const GetMoreInfo(this.currentItem);
//
//   @override
//   List<Object?> get props => [];
// }