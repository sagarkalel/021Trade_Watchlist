import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_021_watchlist/data/models/stock_model.dart';
import 'package:trade_021_watchlist/features/watchlist/screens/edit_watchlist_screen.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/watchlist_model.dart';
import '../bloc/watchlist_bloc.dart';
import '../widgets/stock_tile.dart';
import '../widgets/top_stock_header.dart';

part '../widgets/bottom_nav_bar.dart';
part '../widgets/edit_watchlist_button.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WatchlistLoadedState) {
            return _buildWatchListBody(context);
          }
          if (state is WatchlistErrorState) {
            return Center(child: Text(state.errorMsg));
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: _BottomNav(),
    );
  }

  Widget _buildWatchListBody(BuildContext context) {
    final cubit = context.read<WatchlistBloc>();
    return Column(
      children: [
        // Black status bar spacer
        Container(
          color: AppColors.darkColor,
          height: MediaQuery.of(context).padding.top,
        ),
        // Top Stocks header
        TopStockHeader(topStocks: cubit.topStocks),
        const Divider(height: 0),

        // Search bar
        _buildSearchBar(),
        const Divider(height: 0),

        // Watchlist tabs
        _buildWatchlistTabBar(cubit.watchlists, cubit.selectedWatchlistIndex),
        const Divider(height: 0),

        // Sort by + list
        Expanded(child: _buildStockList(cubit.activeWatchlist.stocks)),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.searchBar,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            SizedBox(width: 12),
            Icon(Icons.search, color: AppColors.secondaryText, size: 20),
            SizedBox(width: 8),
            Text(
              'Search for instruments',
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWatchlistTabBar(
    List<WatchlistModel> watchlists,
    int selectedIndex,
  ) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: watchlists.length,
        itemBuilder: (context, index) {
          final bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () =>
                context.read<WatchlistBloc>().add(SelectWatchlistEvent(index)),
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? AppColors.darkColor
                        : Colors.transparent,
                    width: 2.5,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                watchlists[index].name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected ? AppColors.darkColor : AppColors.greyColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStockList(List<StockModel> stocks) {
    return Column(
      children: [
        // Sort by row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _buildSortByButton(),

              //! I have added here edit button to swap or reorder stocks, as i didn't see anywhere edit button in provided video
              const SizedBox(width: 16),
              const _EditWatchlistButton(),
            ],
          ),
        ),
        // Stock tiles
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: stocks.length,
            itemBuilder: (context, index) {
              return StockTile(
                key: ValueKey(stocks[index].id),
                stock: stocks[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSortByButton() {
    return ElevatedButton.icon(
      onPressed: () {
        //? We can add here sorting logic
      },
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        backgroundColor: AppColors.lightGreyColor,
        foregroundColor: AppColors.primaryText,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      label: Text("Sort by"),
      icon: Icon(Icons.tune),
    );
  }
}
