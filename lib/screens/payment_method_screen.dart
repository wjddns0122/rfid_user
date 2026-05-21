import 'package:flutter/material.dart';

import 'pickup_delivery_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedMethod = 'kakao';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        topChild: _NextButtonBar(onPressed: _openPickupDelivery),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _PaymentHeader(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '결제 방법을 선택해주세요.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        height: 20 / 14,
                        color: AppTheme.textSub,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _PaymentSection(
                      title: '간편결제',
                      children: [
                        PaymentMethodTile(
                          id: 'kakao',
                          label: '카카오페이',
                          selectedId: _selectedMethod,
                          badge: const _PayBadge(
                            label: 'pay',
                            backgroundColor: Color(0xFFFACC15),
                            textColor: Colors.black,
                          ),
                          onSelected: _selectMethod,
                        ),
                        PaymentMethodTile(
                          id: 'naver',
                          label: '네이버페이',
                          selectedId: _selectedMethod,
                          badge: const _PayBadge(
                            label: 'pay',
                            backgroundColor: Color(0xFF03C75A),
                            textColor: Colors.white,
                          ),
                          onSelected: _selectMethod,
                        ),
                        PaymentMethodTile(
                          id: 'toss',
                          label: '토스페이',
                          selectedId: _selectedMethod,
                          badge: const _IconBadge(icon: Icons.circle),
                          onSelected: _selectMethod,
                        ),
                        PaymentMethodTile(
                          id: 'samsung',
                          label: '삼성페이',
                          selectedId: _selectedMethod,
                          badge: const _SamsungBadge(),
                          onSelected: _selectMethod,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _PaymentSection(
                      title: '계좌/카드 결제',
                      children: [
                        PaymentMethodTile(
                          id: 'card',
                          label: '신용/체크카드',
                          selectedId: _selectedMethod,
                          badge: const _IconBadge(
                            icon: Icons.credit_card_outlined,
                            color: Color(0xFF3B82F6),
                          ),
                          onSelected: _selectMethod,
                        ),
                        PaymentMethodTile(
                          id: 'transfer',
                          label: '계좌이체',
                          selectedId: _selectedMethod,
                          badge: const _IconBadge(
                            icon: Icons.campaign_outlined,
                            color: Color(0xFF60A5FA),
                          ),
                          onSelected: _selectMethod,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectMethod(String id) {
    setState(() => _selectedMethod = id);
  }

  void _openPickupDelivery() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PickupDeliveryScreen()),
    );
  }
}

class _PaymentHeader extends StatelessWidget {
  final VoidCallback onBack;

  const _PaymentHeader({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
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
              '결제 방법 선택',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
                height: 28 / 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const _StepIndicator(currentStep: 2),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;

  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 240,
        child: Row(
          children: List.generate(5, (index) {
            if (index.isOdd) {
              return const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Divider(height: 1, color: AppTheme.borderGray),
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
                color: isCurrent ? AppTheme.cartPrimary : AppTheme.surfaceGray,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$step',
                style: TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  fontWeight: FontWeight.bold,
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

class _PaymentSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _PaymentSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppTheme.surfaceGray),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: children),
        ),
      ],
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final String id;
  final String label;
  final String selectedId;
  final Widget badge;
  final ValueChanged<String> onSelected;

  const PaymentMethodTile({
    super.key,
    required this.id,
    required this.label,
    required this.selectedId,
    required this.badge,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final selected = id == selectedId;

    return InkWell(
      onTap: () => onSelected(id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppTheme.borderGray)),
        ),
        child: Row(
          children: [
            SizedBox(width: 48, height: 24, child: Center(child: badge)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            _RadioDot(selected: selected),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  final bool selected;

  const _RadioDot({required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? AppTheme.cartPrimary : Colors.white,
        border: Border.all(
          color: selected ? AppTheme.cartPrimary : const Color(0xFFD1D5DB),
        ),
        shape: BoxShape.circle,
      ),
      child: selected
          ? Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}

class _PayBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const _PayBadge({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          height: 15 / 10,
          fontWeight: FontWeight.w900,
          color: textColor,
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _IconBadge({required this.icon, this.color = AppTheme.textMain});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 20, color: color);
  }
}

class _SamsungBadge extends StatelessWidget {
  const _SamsungBadge();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'SAMSUNG\nPay',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 10,
        height: 12.5 / 10,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E40AF),
      ),
    );
  }
}

class _NextButtonBar extends StatelessWidget {
  final VoidCallback onPressed;

  const _NextButtonBar({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
