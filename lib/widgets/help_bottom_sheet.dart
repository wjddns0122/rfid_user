import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HelpBottomSheet extends StatelessWidget {
  const HelpBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const HelpBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9, // Adjust as needed
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildHelpItem(
                    iconData: Icons.straighten, // Mocking ruler icon
                    title: '사이즈 문의',
                    subtitle: '사이즈 정보 및 추천이 필요하신가요?',
                  ),
                  const SizedBox(height: 16),
                  _buildHelpItem(
                    iconData: Icons.inventory_2_outlined, // Mocking box icon
                    title: '재고 문의',
                    subtitle: '상품의 재고 확인이 필요하신가요?',
                  ),
                  const SizedBox(height: 16),
                  _buildHelpItem(
                    iconData: Icons.help_outline, // Mocking question mark icon
                    title: '기타 문의',
                    subtitle: '그 외 궁금하신 내용을 문의해주세요.',
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: MediaQuery.of(context).padding.bottom + 24,
            ),
            child: _buildStaffCallCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '도움 / 호출',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppTheme.textMain),
                onPressed: () => Navigator.of(context).pop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '원하시는 항목을 선택해주세요.',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSub,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem({
    required IconData iconData,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.surfaceGray),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppTheme.accentYellow,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, size: 28, color: Colors.black), // TODO: Replace with custom SVG
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textMain,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSub,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 20, color: AppTheme.textHint), // TODO: Replace with custom SVG
        ],
      ),
    );
  }

  Widget _buildStaffCallCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.surfaceGray),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.headset_mic_outlined, size: 32, color: AppTheme.textMain), // TODO: Replace with custom SVG
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '직원 호출하기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textMain,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '바로 도움을 받고 싶으신가요?',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSub,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
