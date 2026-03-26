import 'package:get_it/get_it.dart';

import '../data/repositories/watchlist_repository.dart';
import '../features/watchlist/bloc/watchlist_bloc.dart';

final GetIt getIt = GetIt.instance;

void injectDependency() {
  getIt.registerLazySingleton<WatchlistRepository>(() => WatchlistRepository());

  getIt.registerFactory<WatchlistBloc>(
    () => WatchlistBloc(repository: getIt<WatchlistRepository>()),
  );
}
