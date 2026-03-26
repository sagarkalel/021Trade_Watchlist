import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/stock_model.dart';
import '../../../data/models/watchlist_model.dart';
import '../../../data/repositories/watchlist_repository.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistRepository _repository;

  WatchlistBloc({required WatchlistRepository repository})
    : _repository = repository,
      super(const WatchlistInitialState()) {
    on<LoadWatchlistsEvent>(_onLoad);
    on<SelectWatchlistEvent>(_onSelect);
    on<ReorderStockEvent>(_onReorder);
    on<DeleteStockEvent>(_onDelete);
    on<SaveWatchlistEvent>(_onSave);
  }

  //? We can add below logic in state class as well, it wake make more maintainable when we have more complex states, but for this demo, I am keeping it here for simplicity.
  List<WatchlistModel> watchlists = [];
  List<StockModel> topStocks = [];
  int selectedWatchlistIndex = 0;
  WatchlistModel get activeWatchlist => watchlists[selectedWatchlistIndex];

  void _onLoad(LoadWatchlistsEvent event, Emitter<WatchlistState> emit) {
    emit(const WatchlistLoadingState());
    try {
      watchlists = _repository.getWatchlists();
      topStocks = _repository.getTopStocks();
      emit(WatchlistLoadedState());
    } catch (e) {
      emit(WatchlistErrorState(e.toString()));
    }
  }

  void _onSelect(SelectWatchlistEvent event, Emitter<WatchlistState> emit) {
    emit(WatchlistLoadingState());
    selectedWatchlistIndex = event.index;
    emit(WatchlistLoadedState());
  }

  void _onReorder(ReorderStockEvent event, Emitter<WatchlistState> emit) {
    emit(WatchlistLoadingState());

    int newIndex = event.newIndex;
    if (event.oldIndex < newIndex) newIndex -= 1;

    final updatedStocks = List<StockModel>.from(activeWatchlist.stocks);
    final StockModel moved = updatedStocks.removeAt(event.oldIndex);
    updatedStocks.insert(newIndex, moved);

    final updatedWatchlist = activeWatchlist.copyWith(stocks: updatedStocks);
    final updatedWatchlists = List<WatchlistModel>.from(watchlists);
    updatedWatchlists[selectedWatchlistIndex] = updatedWatchlist;
    watchlists = updatedWatchlists;
    emit(WatchlistLoadedState());
  }

  void _onDelete(DeleteStockEvent event, Emitter<WatchlistState> emit) {
    emit(WatchlistLoadingState());

    final updatedStocks = activeWatchlist.stocks
        .where((s) => s.id != event.stockId)
        .toList();

    final updatedWatchlist = activeWatchlist.copyWith(stocks: updatedStocks);
    final updatedWatchlists = List<WatchlistModel>.from(watchlists);
    updatedWatchlists[selectedWatchlistIndex] = updatedWatchlist;
    watchlists = updatedWatchlists;
    emit(WatchlistLoadedState());
  }

  void _onSave(SaveWatchlistEvent event, Emitter<WatchlistState> emit) async {
    emit(WatchlistLoadingState());

    //! In real app, this would involve an API call.
    final updatedWatchlist = watchlists.map((e) {
      if (e.id == activeWatchlist.id) {
        return activeWatchlist.copyWith(name: event.watchlistName);
      } else {
        return e;
      }
    }).toList();
    watchlists = updatedWatchlist;

    emit(WatchlistLoadedState());
  }
}
