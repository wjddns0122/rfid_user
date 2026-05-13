import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/scan_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavBar({
    super.key,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: const Border(top: BorderSide(color: AppTheme.surfaceGray)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, '홈', selectedIndex == 0),
          _buildNavItem(Icons.shopping_cart_outlined, '장바구니', selectedIndex == 1),
          _buildScanButton(context, selectedIndex == 2),
          _buildNavItem(Icons.map_outlined, '매장 지도', selectedIndex == 3),
          _buildNavItem(Icons.person_outline, '내정보', selectedIndex == 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    final color = isSelected ? AppTheme.primary : AppTheme.textHint;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 24, color: color), // TODO: Replace with custom SVG
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
    );
  }

  Widget _buildScanButton(BuildContext context, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanScreen()),
          );
        }
      },
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
                  color: AppTheme.primary.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 24), // TODO: Replace with custom SVG
          ),
          const Text(
            '스캔',
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.primary),
          ),
        ],
      ),
    );
  }
}
