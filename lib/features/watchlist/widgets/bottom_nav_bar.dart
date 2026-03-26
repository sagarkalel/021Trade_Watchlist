part of '../screens/watchlist_screen.dart';

class _BottomNav extends StatefulWidget {
  @override
  State<_BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<_BottomNav> {
  //! I am not using this index as i have not added other screens, if we want to use we can use pageview or indexed widget or tab barview widget to achieve view switching
  int _currentIndex = 0;

  //! adding static navbar items but not displayed screens for each tab, for now just displayed watchlist screen
  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.bookmark_border, label: 'Watchlist'),
    _NavItem(icon: Icons.shopping_cart_outlined, label: 'Orders'),
    _NavItem(icon: Icons.bolt, label: 'GTT+'),
    _NavItem(icon: Icons.work_outline, label: 'Portfolio'),
    _NavItem(icon: Icons.account_balance_wallet_outlined, label: 'Funds'),
    _NavItem(icon: Icons.person_outline, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.divider, width: 0.8)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _currentIndex = i),
        items: _items
            .map(
              (e) =>
                  BottomNavigationBarItem(icon: Icon(e.icon), label: e.label),
            )
            .toList(),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
