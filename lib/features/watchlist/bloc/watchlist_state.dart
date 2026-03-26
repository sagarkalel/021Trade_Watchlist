part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

class WatchlistInitialState extends WatchlistState {
  const WatchlistInitialState();
}

class WatchlistLoadingState extends WatchlistState {
  const WatchlistLoadingState();
}

class WatchlistLoadedState extends WatchlistState {
  const WatchlistLoadedState();
}

class WatchlistErrorState extends WatchlistState {
  final String errorMsg;
  const WatchlistErrorState(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
