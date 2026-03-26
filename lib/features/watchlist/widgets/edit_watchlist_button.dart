part of '../screens/watchlist_screen.dart';

class _EditWatchlistButton extends StatelessWidget {
  const _EditWatchlistButton();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state is! WatchlistLoadedState) return const SizedBox.shrink();
        return ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<WatchlistBloc>(),
                  child: const EditWatchlistScreen(),
                ),
              ),
            );
          },

          style: ElevatedButton.styleFrom(
            visualDensity: VisualDensity.compact,
            backgroundColor: AppColors.lightGreyColor,
            foregroundColor: AppColors.primaryText,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          label: Text("Edit"),
          icon: Icon(Icons.edit_outlined),
        );
      },
    );
  }
}
