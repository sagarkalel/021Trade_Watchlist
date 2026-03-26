import 'package:flutter/material.dart';
import 'package:trade_021_watchlist/data/models/stock_model.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/number_formatter.dart';

class TopStockHeader extends StatelessWidget {
  final List<StockModel> topStocks;

  const TopStockHeader({super.key, required this.topStocks});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          if (topStocks.isNotEmpty)
            Expanded(
              child: _buildTopStockCard(model: topStocks[0], showArrow: false),
            ),
          if (topStocks.length > 1) ...[
            Container(width: 1, height: 48, color: AppColors.divider),
            Expanded(
              child: _buildTopStockCard(model: topStocks[1], showArrow: true),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTopStockCard({
    required StockModel model,
    required bool showArrow,
  }) {
    final Color changeColor = model.isPositive
        ? AppColors.positive
        : AppColors.negative;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  model.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (model.subTitle.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(
                  model.subTitle,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (showArrow) ...[
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: AppColors.secondaryText,
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                NumberFormatter.formatWithCommas(model.value),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  '${model.isPositive ? '' : ''}${NumberFormatter.formatWithCommas(model.change)} '
                  '(${model.changePercent.toStringAsFixed(2)}...',
                  style: TextStyle(
                    fontSize: 12,
                    color: changeColor,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
