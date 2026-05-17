import 'package:flutter/material.dart';

import 'order_complete_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  static const _products = [
    _OrderProductData(
      '오버핏 블레이저',
      '블랙 / L',
      '89,000원',
      '1개',
      Icons.flutter_dash,
    ),
    _OrderProductData('후드 스웨트셔츠', '오트밀 / M', '49,000원', '1개', Icons.blur_on),
    _OrderProductData('와이드 데님 팬츠', '블루 / M', '59,000원', '1개', Icons.person),
    _OrderProductData('볼캡', '블랙', '19,000원', '1개', Icons.brightness_5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        topChild: _OrderActionBar(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const OrderCompleteScreen(),
            ),
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _OrderHeader(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _OrderStepIndicator(),
                    const SizedBox(height: 20),
                    const _OrderSummaryHeader(),
                    const SizedBox(height: 8),
                    ..._products.map(
                      (product) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _OrderProductItem(product: product),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const _PriceBreakdown(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderHeader extends StatelessWidget {
  final VoidCallback onBack;

  const _OrderHeader({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.chevron_left, size: 30),
            ),
          ),
          Text(
            '주문 확인',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 18,
              height: 28 / 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderStepIndicator extends StatelessWidget {
  const _OrderStepIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(7, (index) {
        if (index.isOdd) {
          return Container(
            width: 20,
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFD1D5DB))),
            ),
          );
        }

        final step = (index ~/ 2) + 1;
        final active = step == 4;
        return Opacity(
          opacity: active ? 1 : 0.2,
          child: Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: active ? const Color(0xFF6343C7) : Colors.white,
              border: active ? null : Border.all(color: AppTheme.textHint),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 10,
                height: 15 / 10,
                fontWeight: active ? FontWeight.bold : FontWeight.w400,
                color: active ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _OrderSummaryHeader extends StatelessWidget {
  const _OrderSummaryHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '주문 상품',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          '4개 상품',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 12,
            height: 16 / 12,
            fontWeight: FontWeight.w500,
            color: AppTheme.textHint,
          ),
        ),
      ],
    );
  }
}

class _OrderProductItem extends StatelessWidget {
  final _OrderProductData product;

  const _OrderProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProductImagePlaceholder(icon: product.icon),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 96,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 14,
                    height: 17.5 / 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  product.option,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    height: 16.5 / 11,
                    color: AppTheme.textHint,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product.price,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 14,
                        height: 20 / 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      product.quantity,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        height: 16 / 12,
                        color: AppTheme.textSub,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductImagePlaceholder extends StatelessWidget {
  final IconData icon;

  const _ProductImagePlaceholder({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 96,
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray,
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.textMain.withValues(alpha: 0.92),
                  AppTheme.textSub.withValues(alpha: 0.55),
                ],
              ),
            ),
          ),
          Icon(icon, size: 36, color: Colors.white.withValues(alpha: 0.75)),
          const Positioned(
            left: 6,
            right: 6,
            bottom: 6,
            child: Text(
              'TODO: Figma asset',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 6, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceBreakdown extends StatelessWidget {
  const _PriceBreakdown();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 17),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.surfaceGray)),
      ),
      child: Column(
        children: const [
          _PriceRow(label: '상품 금액', value: '216,000원'),
          SizedBox(height: 10),
          _PriceRow(label: '배송/픽업', value: '0원'),
          SizedBox(height: 10),
          _PriceRow(label: '할인 금액', value: '0원'),
          SizedBox(height: 12),
          _PriceRow(label: '총 결제 금액', value: '216,000원', emphasized: true),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasized;

  const _PriceRow({
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: emphasized ? 16 : 14,
            height: (emphasized ? 24 : 20) / (emphasized ? 16 : 14),
            fontWeight: emphasized ? FontWeight.bold : FontWeight.w400,
            color: emphasized ? Colors.black : AppTheme.textHint,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: emphasized ? 18 : 14,
            height: (emphasized ? 28 : 20) / (emphasized ? 18 : 14),
            fontWeight: emphasized ? FontWeight.bold : FontWeight.w500,
            color: emphasized ? const Color(0xFF6343C7) : Colors.black,
          ),
        ),
      ],
    );
  }
}

class _OrderActionBar extends StatelessWidget {
  final VoidCallback onPressed;

  const _OrderActionBar({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          fixedSize: const Size.fromHeight(56),
          backgroundColor: const Color(0xFF6343C7),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
          shadowColor: const Color(0xFFF3E8FF),
        ),
        child: Text(
          '주문하기',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _OrderProductData {
  final String title;
  final String option;
  final String price;
  final String quantity;
  final IconData icon;

  const _OrderProductData(
    this.title,
    this.option,
    this.price,
    this.quantity,
    this.icon,
  );
}
