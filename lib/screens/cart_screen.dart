import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'payment_method_screen.dart';
import '../services/scan_log.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_product_item.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: logsRef.onValue,
      builder: (context, snapshot) {
        final scans = parseScans(snapshot.data?.snapshot);
        final totalPrice = scans.fold<int>(0, (sum, s) => sum + s.lineTotal);
        final totalQty = scans.fold<int>(0, (sum, s) => sum + s.quantity);
        final totalText = formatWon(totalPrice);
        final waiting =
            snapshot.connectionState == ConnectionState.waiting;

        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: 1,
            topChild: _CartSummaryBar(
              itemCount: totalQty,
              totalText: totalText,
              onCheckout: () => _openPaymentMethod(context),
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
                        _ProductSectionHeader(count: scans.length),
                        const SizedBox(height: 16),
                        if (waiting)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 48),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        else if (scans.isEmpty)
                          const _EmptyState()
                        else
                          ...List.generate(scans.length, (index) {
                            final scan = scans[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index == scans.length - 1 ? 0 : 24,
                              ),
                              child: CartProductItem(
                                title: scan.name,
                                option: scan.uid,
                                price: formatWon(scan.price),
                                quantity: scan.quantity,
                                isSelected: true,
                                placeholderIcon: scan.icon,
                                onToggleSelected: () {},
                                onDecrease: () {},
                                onIncrease: () {},
                                checkboxKey: ValueKey('cart-item-${scan.key}'),
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
      },
    );
  }

  void _openPaymentMethod(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PaymentMethodScreen()),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Text(
          '아직 인식된 상품이 없습니다.\nRFID 태그를 인식해 주세요.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: AppTheme.textHint, height: 1.5),
        ),
      ),
    );
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
  final int count;

  const _ProductSectionHeader({required this.count});

  @override
  Widget build(BuildContext context) {
    return Text(
      '인식된 상품 ($count)',
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
