import '../models/stock_model.dart';
import '../models/watchlist_model.dart';

//! I am assuming here subTitle can be: NSE, BSE, IDX

class WatchlistRepository {
  // i am displaying same values from your provided video
  List<StockModel> getTopStocks() {
    return const [
      StockModel(
        id: "id_1",
        title: 'SENSEX 18TH SEP 8...',
        subTitle: 'BSE',
        value: 1225.55,
        change: 144.50,
        changePercent: 13.34,
      ),
      StockModel(
        id: "id_2",
        title: 'NIFTY BANK',
        subTitle: '',
        value: 54172.85,
        change: -14.05,
        changePercent: -0.03,
      ),
    ];
  }

  // here as well same values from your provided video
  List<WatchlistModel> getWatchlists() {
    return [
      WatchlistModel(
        id: 'wishlist_1',
        name: 'Watchlist 1',
        stocks: const [
          StockModel(
            id: 's1',
            title: 'RELIANCE',
            subTitle: 'NSE | EQ',
            value: 1374.00,
            change: -4.50,
            changePercent: -0.33,
          ),
          StockModel(
            id: 's2',
            title: 'HDFCBANK',
            subTitle: 'NSE | EQ',
            value: 966.85,
            change: 0.85,
            changePercent: 0.09,
          ),
          StockModel(
            id: 's3',
            title: 'ASIANPAINT',
            subTitle: 'NSE | EQ',
            value: 2537.40,
            change: 6.60,
            changePercent: 0.26,
          ),
          StockModel(
            id: 's4',
            title: 'NIFTY IT',
            subTitle: 'IDX',
            value: 35187.55,
            change: 877.11,
            changePercent: 2.56,
          ),
          StockModel(
            id: 's5',
            title: 'RELIANCE SEP 1880 CE',
            subTitle: 'NSE | Monthly',
            value: 0.00,
            change: 0.00,
            changePercent: 0.00,
          ),
          StockModel(
            id: 's6',
            title: 'RELIANCE SEP 1370 PE',
            subTitle: 'NSE | Monthly',
            value: 19.20,
            change: 1.00,
            changePercent: 5.49,
          ),
          StockModel(
            id: 's7',
            title: 'MRF',
            subTitle: 'NSE | EQ',
            value: 147625.00,
            change: 550.00,
            changePercent: 0.37,
          ),
          StockModel(
            id: 's8',
            title: 'MRF',
            subTitle: 'BSE | EQ',
            value: 147439.45,
            change: 463.80,
            changePercent: 0.32,
          ),
        ],
      ),
      WatchlistModel(
        id: 'wishlist_5',
        name: 'Watchlist 5',
        stocks: const [
          StockModel(
            id: 's9',
            title: 'INFY',
            subTitle: 'NSE | EQ',
            value: 1423.90,
            change: -5.80,
            changePercent: -0.41,
          ),
          StockModel(
            id: 's10',
            title: 'TCS',
            subTitle: 'NSE | EQ',
            value: 3512.75,
            change: -18.25,
            changePercent: -0.52,
          ),
        ],
      ),
      WatchlistModel(
        id: 'wishlist_6',
        name: 'Watchlist 6',
        stocks: const [
          StockModel(
            id: 's11',
            title: 'BAJFINANCE',
            subTitle: 'NSE | EQ',
            value: 6934.00,
            change: 115.50,
            changePercent: 1.69,
          ),
        ],
      ),
    ];
  }
}
