import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/cart_screen.dart';
import '../screens/scan_screen.dart';
import '../screens/store_info_screen.dart';
import '../screens/profile_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Widget? topChild;

  const CustomBottomNavBar({super.key, this.selectedIndex = 0, this.topChild});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ?topChild,
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            border: const Border(top: BorderSide(color: AppTheme.surfaceGray)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(context, Icons.home, '홈', 0, selectedIndex == 0),
              _buildNavItem(
                context,
                Icons.shopping_cart_outlined,
                '장바구니',
                1,
                selectedIndex == 1,
              ),
              _buildScanButton(context, selectedIndex == 2),
              _buildNavItem(
                context,
                Icons.shopping_bag_outlined,
                '매장 정보',
                3,
                selectedIndex == 3,
              ),
              _buildNavItem(
                context,
                Icons.person_outline,
                '내정보',
                4,
                selectedIndex == 4,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(IconData icon, bool isSelected, Color color) {
    if (!isSelected) {
      return Icon(icon, size: 24, color: color);
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppTheme.cartPrimarySoft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 24, color: color),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
    bool isSelected,
  ) {
    final color = isSelected ? AppTheme.primary : AppTheme.textHint;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _handleTap(context, index, isSelected),
      child: SizedBox(
        width: 56,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(icon, isSelected, color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanButton(BuildContext context, bool isSelected) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _handleTap(context, 2, isSelected),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
              size: 24,
            ), // TODO: Replace with custom SVG
          ),
          const Text(
            '스캔',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(BuildContext context, int index, bool isSelected) {
    if (isSelected) {
      return;
    }

    switch (index) {
      case 0:
        Navigator.of(context).popUntil((route) => route.isFirst);
        return;
      case 1:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const CartScreen()));
        return;
      case 2:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ScanScreen()),
          (route) => route.isFirst,
        );
        return;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const StoreInfoScreen()),
        );
        return;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        return;
      default:
        final label = switch (index) {
          1 => '장바구니',
          3 => '매장 지도',
          _ => '해당',
        };

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('$label 메뉴는 준비 중입니다.'),
              duration: const Duration(seconds: 1),
            ),
          );
        return;
    }
  }
}
