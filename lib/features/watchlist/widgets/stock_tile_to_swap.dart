import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/stock_model.dart';

class StockTileToSwap extends StatelessWidget {
  final StockModel stock;
  final int index;
  final VoidCallback onDelete;

  const StockTileToSwap({
    super.key,
    required this.stock,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.drag_handle,
                    color: AppColors.primaryText,
                    size: 22,
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  stock.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              IconButton(
                onPressed: onDelete,
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.delete_rounded,
                  color: AppColors.primaryText,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
        const Divider(indent: 16, endIndent: 0, height: 0),
      ],
    );
  }
}
