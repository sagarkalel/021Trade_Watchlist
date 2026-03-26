part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWatchlistsEvent extends WatchlistEvent {
  const LoadWatchlistsEvent();
}

class SelectWatchlistEvent extends WatchlistEvent {
  final int index;
  const SelectWatchlistEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class ReorderStockEvent extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;
  const ReorderStockEvent({required this.oldIndex, required this.newIndex});

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class DeleteStockEvent extends WatchlistEvent {
  final String stockId;
  const DeleteStockEvent(this.stockId);

  @override
  List<Object?> get props => [stockId];
}

class SaveWatchlistEvent extends WatchlistEvent {
  final String watchlistName;
  const SaveWatchlistEvent(this.watchlistName);
  @override
  List<Object?> get props => [watchlistName];
}
