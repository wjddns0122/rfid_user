import 'package:flutter/material.dart';

import 'payment_method_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_product_item.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<int> _quantities = [1, 1, 1, 1];
  final List<bool> _selectedItems = [true, true, true, true];

  static const _products = [
    _CartProductData(
      title: '오버핏 블레이저',
      option: '블랙 / L',
      price: 89000,
      icon: Icons.watch_outlined,
    ),
    _CartProductData(
      title: '후드 스웨트셔츠',
      option: '오트밀 / M',
      price: 49000,
      icon: Icons.checkroom_outlined,
    ),
    _CartProductData(
      title: '와이드 데님 팬츠',
      option: '블루 / M',
      price: 59000,
      icon: Icons.texture_outlined,
    ),
    _CartProductData(
      title: '볼캡',
      option: '블랙',
      price: 19000,
      icon: Icons.blur_circular_outlined,
    ),
  ];

  int get _totalPrice {
    var total = 0;
    for (var index = 0; index < _products.length; index += 1) {
      if (!_selectedItems[index]) {
        continue;
      }
      total += _products[index].price * _quantities[index];
    }
    return total;
  }

  int get _selectedItemCount {
    var count = 0;
    for (var index = 0; index < _products.length; index += 1) {
      if (_selectedItems[index]) {
        count += _quantities[index];
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final totalText = _formatWon(_totalPrice);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        topChild: _CartSummaryBar(
          itemCount: _selectedItemCount,
          totalText: totalText,
          onCheckout: _openPaymentMethod,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _CartHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _RfidBanner(),
                    const SizedBox(height: 20),
                    const _ProductSectionHeader(),
                    const SizedBox(height: 16),
                    ...List.generate(_products.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == _products.length - 1 ? 0 : 24,
                        ),
                        child: CartProductItem(
                          title: _products[index].title,
                          option: _products[index].option,
                          price: _formatWon(_products[index].price),
                          quantity: _quantities[index],
                          isSelected: _selectedItems[index],
                          placeholderIcon: _products[index].icon,
                          onToggleSelected: () => _toggleSelected(index),
                          onDecrease: () => _decrease(index),
                          onIncrease: () => _increase(index),
                          checkboxKey: ValueKey('cart-item-$index-checkbox'),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _decrease(int index) {
    if (_quantities[index] == 1) {
      return;
    }
    setState(() => _quantities[index] -= 1);
  }

  void _increase(int index) {
    setState(() => _quantities[index] += 1);
  }

  void _toggleSelected(int index) {
    setState(() => _selectedItems[index] = !_selectedItems[index]);
  }

  void _openPaymentMethod() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PaymentMethodScreen()),
    );
  }

  static String _formatWon(int value) {
    final raw = value.toString();
    final buffer = StringBuffer();
    for (var index = 0; index < raw.length; index += 1) {
      final reverseIndex = raw.length - index;
      buffer.write(raw[index]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write(',');
      }
    }
    return '$buffer원';
  }
}

class _CartHeader extends StatelessWidget {
  const _CartHeader();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            '장바구니',
            style: textTheme.titleMedium?.copyWith(
              fontSize: 18,
              height: 28 / 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textMain,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '편집',
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSub,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RfidBanner extends StatelessWidget {
  const _RfidBanner();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLightGray,
        border: Border.all(color: AppTheme.surfaceGray),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'RFID가 인식한 상품이 장바구니에 담겼습니다.',
              style: textTheme.bodySmall?.copyWith(
                fontSize: 13,
                height: 19.5 / 13,
                color: AppTheme.textSub,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: AppTheme.successSurface,
              border: Border.all(color: AppTheme.successBorder),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '연결됨',
              style: textTheme.labelSmall?.copyWith(
                fontSize: 11,
                height: 16.5 / 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.successText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductSectionHeader extends StatelessWidget {
  const _ProductSectionHeader();

  @override
  Widget build(BuildContext context) {
    return Text(
      '인식된 상품 (4)',
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.textMain,
      ),
    );
  }
}

class _CartSummaryBar extends StatelessWidget {
  final int itemCount;
  final String totalText;
  final VoidCallback onCheckout;

  const _CartSummaryBar({
    required this.itemCount,
    required this.totalText,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppTheme.borderSubtle)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '전체 $itemCount개 상품',
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    height: 16 / 12,
                    color: AppTheme.textHint,
                  ),
                ),
                Text(
                  totalText,
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: 14,
                    height: 20 / 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textMain,
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: onCheckout,
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.cartPrimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              shadowColor: Colors.black.withValues(alpha: 0.18),
            ),
            child: Text(
              '결제하기 ($totalText)',
              style: textTheme.labelLarge?.copyWith(
                fontSize: 15,
                height: 22.5 / 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartProductData {
  final String title;
  final String option;
  final int price;
  final IconData icon;

  const _CartProductData({
    required this.title,
    required this.option,
    required this.price,
    required this.icon,
  });
}
