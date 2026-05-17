import 'package:flutter/material.dart';

import 'order_confirmation_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class PickupDeliveryScreen extends StatefulWidget {
  const PickupDeliveryScreen({super.key});

  @override
  State<PickupDeliveryScreen> createState() => _PickupDeliveryScreenState();
}

class _PickupDeliveryScreenState extends State<PickupDeliveryScreen> {
  bool _isPickup = true;
  String _selectedStore = 'hongdae';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        topChild: _NextActionBar(onPressed: _openOrderConfirmation),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _PickupDeliveryHeader(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _OrderStepIndicator(currentStep: 3),
                    const SizedBox(height: 32),
                    Text(
                      '픽업 또는 배송 방법을 선택해주세요.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        height: 20 / 14,
                        color: AppTheme.textHint,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _PickupDeliveryTabs(
                      isPickup: _isPickup,
                      onChanged: (value) => setState(() => _isPickup = value),
                    ),
                    const SizedBox(height: 32),
                    if (_isPickup) ...[
                      _StoreOptionCard(
                        title: '스테이션 게이트 홍대점',
                        address: '서울 마포구 양화로 188 AK 플라자 3F',
                        hours: '운영시간 10:00 - 21:00',
                        selected: _selectedStore == 'hongdae',
                        onTap: () => setState(() => _selectedStore = 'hongdae'),
                      ),
                      const SizedBox(height: 16),
                      _StoreOptionCard(
                        title: '스테이션 게이트 강남점',
                        address: '서울 강남구 강남대로 396 신분당 2F',
                        hours: '운영시간 10:00 - 22:00',
                        selected: _selectedStore == 'gangnam',
                        onTap: () => setState(() => _selectedStore = 'gangnam'),
                      ),
                      const SizedBox(height: 24),
                      const _InfoMessage(),
                      const SizedBox(height: 24),
                      const _PickupTimeRow(),
                    ] else
                      const _DeliveryMock(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openOrderConfirmation() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const OrderConfirmationScreen()),
    );
  }
}

class _PickupDeliveryHeader extends StatelessWidget {
  final VoidCallback onBack;

  const _PickupDeliveryHeader({required this.onBack});

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
            '픽업/배송 선택',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 18,
              height: 28 / 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderStepIndicator extends StatelessWidget {
  final int currentStep;

  const _OrderStepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 256,
        child: Row(
          children: List.generate(7, (index) {
            if (index.isOdd) {
              final completed = index < (currentStep - 1) * 2;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    height: 2,
                    thickness: 2,
                    color: completed
                        ? AppTheme.cartPrimary
                        : AppTheme.borderGray,
                  ),
                ),
              );
            }

            final step = (index ~/ 2) + 1;
            final isCurrent = step == currentStep;
            return Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isCurrent ? AppTheme.cartPrimary : AppTheme.borderGray,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$step',
                style: TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.w400,
                  color: isCurrent ? Colors.white : AppTheme.textHint,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _PickupDeliveryTabs extends StatelessWidget {
  final bool isPickup;
  final ValueChanged<bool> onChanged;

  const _PickupDeliveryTabs({required this.isPickup, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentButton(
              label: '픽업',
              selected: isPickup,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _SegmentButton(
              label: '배송',
              selected: !isPickup,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 14,
            height: 20 / 14,
            fontWeight: selected ? FontWeight.bold : FontWeight.w500,
            color: selected ? const Color(0xFF9333EA) : AppTheme.textHint,
          ),
        ),
      ),
    );
  }
}

class _StoreOptionCard extends StatelessWidget {
  final String title;
  final String address;
  final String hours;
  final bool selected;
  final VoidCallback onTap;

  const _StoreOptionCard({
    required this.title,
    required this.address,
    required this.hours,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? AppTheme.cartPrimary : AppTheme.borderGray;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(selected ? 18 : 17),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor, width: selected ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      height: 24 / 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      height: 16 / 12,
                      color: AppTheme.textHint,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hours,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      height: 16 / 12,
                      color: AppTheme.textHint,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _SelectionDot(selected: selected),
          ],
        ),
      ),
    );
  }
}

class _SelectionDot extends StatelessWidget {
  final bool selected;

  const _SelectionDot({required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? AppTheme.cartPrimary : Colors.white,
        border: Border.all(
          color: selected ? AppTheme.cartPrimary : AppTheme.borderGray,
        ),
        shape: BoxShape.circle,
      ),
      child: selected
          ? const Icon(Icons.check, size: 13, color: Colors.white)
          : null,
    );
  }
}

class _InfoMessage extends StatelessWidget {
  const _InfoMessage();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 16, color: Color(0xFF9333EA)),
          const SizedBox(width: 8),
          Text(
            '준비 완료 시 알림을 보내드려요.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12,
              height: 16 / 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9333EA),
            ),
          ),
        ],
      ),
    );
  }
}

class _PickupTimeRow extends StatelessWidget {
  const _PickupTimeRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.surfaceGray),
          bottom: BorderSide(color: AppTheme.surfaceGray),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '픽업 준비 시간',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 14,
                    height: 20 / 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '최소 30분 ~ 최대 2시간 소요',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    height: 16 / 12,
                    color: AppTheme.textHint,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: AppTheme.textHint),
        ],
      ),
    );
  }
}

class _DeliveryMock extends StatelessWidget {
  const _DeliveryMock();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppTheme.borderGray),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '배송지는 다음 단계에서 입력할 수 있습니다.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          height: 20 / 14,
          color: AppTheme.textSub,
        ),
      ),
    );
  }
}

class _NextActionBar extends StatelessWidget {
  final VoidCallback onPressed;

  const _NextActionBar({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          fixedSize: const Size.fromHeight(56),
          backgroundColor: AppTheme.cartPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          '다음',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 18,
            height: 28 / 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
