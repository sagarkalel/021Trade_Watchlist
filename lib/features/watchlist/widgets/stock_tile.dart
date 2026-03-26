import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/number_formatter.dart';
import '../../../data/models/stock_model.dart';

class StockTile extends StatelessWidget {
  final StockModel stock;

  const StockTile({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final Color ltpColor = stock.isNegative
        ? AppColors.negative
        : stock.isPositive
        ? AppColors.positive
        : AppColors.neutral;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      stock.subTitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NumberFormatter.formatWithCommas(stock.value),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ltpColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    NumberFormatter.formatChange(
                      stock.change,
                      stock.changePercent,
                    ),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(indent: 16, endIndent: 0, height: 0),
      ],
    );
  }
}
