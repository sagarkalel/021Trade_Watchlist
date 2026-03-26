import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/stock_model.dart';
import '../bloc/watchlist_bloc.dart';
import '../widgets/stock_tile_to_swap.dart';

class EditWatchlistScreen extends StatefulWidget {
  const EditWatchlistScreen({super.key});

  @override
  State<EditWatchlistScreen> createState() => _EditWatchlistScreenState();
}

class _EditWatchlistScreenState extends State<EditWatchlistScreen> {
  late TextEditingController _nameController;
  final _focusNode = FocusNode();
  bool _isEditingName = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<WatchlistBloc>();
    final name = cubit.activeWatchlist.name;
    _nameController = TextEditingController(text: name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            final cubit = context.read<WatchlistBloc>();
            if (state is WatchlistLoadedState) {
              return Text('Edit ${cubit.activeWatchlist.name}');
            }
            return const Text('Edit Watchlist');
          },
        ),
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is! WatchlistLoadedState) return const SizedBox.shrink();

          final cubit = context.read<WatchlistBloc>();
          final stocks = cubit.activeWatchlist.stocks;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: _buildWatchlistNameField(
                  controller: _nameController,
                  focusNode: _focusNode,
                  isEditing: _isEditingName,
                  onEditTap: () async {
                    setState(() => _isEditingName = !_isEditingName);
                    await Future.delayed(const Duration(milliseconds: 100));
                    _focusNode.requestFocus();
                  },
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: ReorderableListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: stocks.length,
                  onReorder: (oldIndex, newIndex) {
                    context.read<WatchlistBloc>().add(
                      ReorderStockEvent(oldIndex: oldIndex, newIndex: newIndex),
                    );
                  },
                  itemBuilder: (context, index) {
                    final StockModel stock = stocks[index];
                    return StockTileToSwap(
                      key: ValueKey(stock.id),
                      stock: stock,
                      index: index,
                      onDelete: () => context.read<WatchlistBloc>().add(
                        DeleteStockEvent(stock.id),
                      ),
                    );
                  },
                ),
              ),

              _buildButtonActions(_onSave),
            ],
          );
        },
      ),
    );
  }

  void _onSave() {
    context.read<WatchlistBloc>().add(SaveWatchlistEvent(_nameController.text));
    Navigator.of(context).pop();
  }

  Widget _buildButtonActions(VoidCallback onSave) {
    return Column(
      children: [
        const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                //? we can add here required logic for this
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: AppColors.outlineButton,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Edit other watchlists',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.saveButton,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save Watchlist',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }

  Widget _buildWatchlistNameField({
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEditTap,
    required FocusNode focusNode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.searchBar,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              enabled: isEditing,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          GestureDetector(
            onTap: onEditTap,
            child: Icon(
              isEditing ? Icons.check : Icons.edit_outlined,
              size: 18,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
