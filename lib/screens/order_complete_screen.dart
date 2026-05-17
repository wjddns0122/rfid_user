import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class OrderCompleteScreen extends StatelessWidget {
  const OrderCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomBottomNavBar(
        selectedIndex: 1,
        topChild: _HomeActionBar(),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _CompleteHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    _SuccessGraphic(),
                    SizedBox(height: 36),
                    _CompleteMessage(),
                    SizedBox(height: 40),
                    _OrderInfoCard(),
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

class _CompleteHeader extends StatelessWidget {
  const _CompleteHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 61,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.surfaceGray)),
      ),
      child: Text(
        '주문 완료',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: 18,
          height: 28 / 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _SuccessGraphic extends StatelessWidget {
  const _SuccessGraphic();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 160,
        height: 132,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const _Confetti(left: 12, top: 18, size: 8, opacity: 1),
            const _Confetti(left: 58, top: 0, size: 6, opacity: 0.5),
            const _Confetti(right: 22, top: 24, size: 8, opacity: 0.9),
            const _Confetti(left: 0, top: 78, size: 8, opacity: 0.6),
            const _Confetti(right: 0, top: 88, size: 6, opacity: 1),
            const _Confetti(left: 38, bottom: 8, size: 6, opacity: 0.4),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: const Color(0xFF6A42C2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE9D5FF).withValues(alpha: 0.9),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(Icons.check, size: 58, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _Confetti extends StatelessWidget {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double size;
  final double opacity;

  const _Confetti({
    this.left,
    this.right,
    this.top,
    this.bottom,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Transform.rotate(
        angle: 0.785398,
        child: Container(
          width: size,
          height: size,
          color: const Color(0xFF6A42C2).withValues(alpha: opacity),
        ),
      ),
    );
  }
}

class _CompleteMessage extends StatelessWidget {
  const _CompleteMessage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '주문이 완료되었습니다!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 24,
            height: 32 / 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '주문 번호',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            height: 20 / 14,
            color: AppTheme.textHint,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'SG250508172941',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 20,
            height: 28 / 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF6A42C2),
          ),
        ),
      ],
    );
  }
}

class _OrderInfoCard extends StatelessWidget {
  const _OrderInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        border: Border.all(color: AppTheme.surfaceGray),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: const [
          _InfoRow(label: '픽업 방법', value: '매장 픽업'),
          SizedBox(height: 16),
          _InfoRow(label: '픽업 매장', value: '스테이션 게이트 홍대점'),
          SizedBox(height: 16),
          _InfoRow(label: '준비 완료 예정', value: '30분 ~ 2시간 이내'),
          SizedBox(height: 24),
          _OrderHistoryButton(),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            height: 20 / 14,
            color: AppTheme.textHint,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textMain,
          ),
        ),
      ],
    );
  }
}

class _OrderHistoryButton extends StatelessWidget {
  const _OrderHistoryButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppTheme.borderGray),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: const Text(
        '주문 내역 확인',
        style: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF374151),
        ),
      ),
    );
  }
}

class _HomeActionBar extends StatelessWidget {
  const _HomeActionBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: FilledButton(
        onPressed: () =>
            Navigator.of(context).popUntil((route) => route.isFirst),
        style: FilledButton.styleFrom(
          fixedSize: const Size.fromHeight(60),
          backgroundColor: const Color(0xFF6A42C2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
          shadowColor: Colors.black.withValues(alpha: 0.18),
        ),
        child: Text(
          '홈으로 이동',
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
