import 'stock_model.dart';

class WatchlistModel {
  final String id;
  final String name;
  final List<StockModel> stocks;

  const WatchlistModel({
    required this.id,
    required this.name,
    required this.stocks,
  });

  WatchlistModel copyWith({
    String? id,
    String? name,
    List<StockModel>? stocks,
  }) {
    return WatchlistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      stocks: stocks ?? this.stocks,
    );
  }
}
