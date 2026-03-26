import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/watchlist/bloc/watchlist_bloc.dart';
import 'features/watchlist/screens/watchlist_screen.dart';
import 'injection/dependency_injecter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injectDependency();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: MaterialApp(
        title: '021 Trade - Watchlist',
        theme: AppTheme.light,
        home: BlocProvider(
          create: (_) =>
              getIt<WatchlistBloc>()..add(const LoadWatchlistsEvent()),
          child: const WatchlistScreen(),
        ),
      ),
    );
  }
}
