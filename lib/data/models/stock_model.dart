//! I am assuming here subTitle can be: NSE, BSE, IDX

class StockModel {
  final String id;
  final String title;
  final String subTitle;
  final double value;
  final double change;
  final double changePercent;

  bool get isPositive => change > 0;
  bool get isNegative => change < 0;

  const StockModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.change,
    required this.changePercent,
  });

  StockModel copyWith({
    String? id,
    String? symbol,
    String? exchange,
    String? instrumentType,
    double? ltp,
    double? change,
    double? changePercent,
  }) {
    return StockModel(
      id: id ?? this.id,
      title: symbol ?? title,
      subTitle: exchange ?? subTitle,

      value: ltp ?? value,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
    );
  }
}
