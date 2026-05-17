import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 4),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _ProfileHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    _ProfileCard(),
                    SizedBox(height: 24),
                    _MenuSection(
                      title: '주문/이용 관리',
                      items: [
                        _ProfileMenuData(
                          icon: Icons.receipt_long_outlined,
                          title: '결제내역',
                          subtitle: '주문 및 결제 내역을 확인해요',
                        ),
                        _ProfileMenuData(
                          icon: Icons.shopping_bag_outlined,
                          title: '픽업/배송 조회',
                          subtitle: '픽업/배송 상태를 확인해요',
                        ),
                      ],
                    ),
                    _MenuSection(
                      title: '쇼핑',
                      showDivider: true,
                      items: [
                        _ProfileMenuData(
                          icon: Icons.shopping_cart_outlined,
                          title: '장바구니',
                          subtitle: '담은 상품을 확인해요',
                        ),
                        _ProfileMenuData(
                          icon: Icons.history_outlined,
                          title: '최근 본 상품',
                          subtitle: '최근 본 상품을 확인해요',
                        ),
                      ],
                    ),
                    _MenuSection(
                      title: '계정 관리',
                      showDivider: true,
                      items: [
                        _ProfileMenuData(
                          icon: Icons.person_outline,
                          title: '회원정보',
                          subtitle: '내 정보를 관리해요',
                        ),
                        _ProfileMenuData(
                          icon: Icons.credit_card_outlined,
                          title: '결제수단 관리',
                          subtitle: '등록된 결제수단을 관리해요',
                        ),
                      ],
                    ),
                    _MenuSection(
                      title: '설정',
                      showDivider: true,
                      items: [
                        _ProfileMenuData(
                          icon: Icons.settings_outlined,
                          title: '환경설정',
                          subtitle: '앱 설정 및 환경을 관리해요',
                        ),
                        _ProfileMenuData(
                          icon: Icons.notifications_none,
                          title: '알림 설정',
                          subtitle: '알림 수신 설정을 관리해요',
                        ),
                      ],
                    ),
                    _MenuSection(
                      title: '고객지원',
                      showDivider: true,
                      items: [
                        _ProfileMenuData(
                          icon: Icons.support_agent_outlined,
                          title: '고객센터',
                          subtitle: '문의 및 도움을 받아보세요',
                        ),
                        _ProfileMenuData(
                          icon: Icons.help_outline,
                          title: 'FAQ',
                          subtitle: '자주 묻는 질문을 확인해요',
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
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '내정보',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20,
              height: 28 / 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textMain,
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.notifications_none, size: 24),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF222222),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: const [
            _ProfileIdentityRow(),
            SizedBox(height: 24),
            _ProfileStatsRow(),
          ],
        ),
      ),
    );
  }
}

class _ProfileIdentityRow extends StatelessWidget {
  const _ProfileIdentityRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Color(0xFFD1D5DB),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person, size: 48, color: Color(0xFF9CA3AF)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '문영우',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      height: 28 / 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.textHint,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'SILVER',
                      style: TextStyle(
                        fontSize: 10,
                        height: 15 / 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFF4ADE80),
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(width: 8, height: 8),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'RFID 연결됨',
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      color: AppTheme.textHint,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileStatsRow extends StatelessWidget {
  const _ProfileStatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _ProfileStat(label: '포인트', value: '12,450P')),
        _VerticalStatDivider(),
        Expanded(child: _ProfileStat(label: '쿠폰', value: '4장')),
        _VerticalStatDivider(),
        Expanded(child: _ProfileStat(label: '보유상품', value: '8개')),
      ],
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            height: 16.5 / 11,
            color: AppTheme.textHint,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _VerticalStatDivider extends StatelessWidget {
  const _VerticalStatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: const Color(0xFF374151));
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_ProfileMenuData> items;
  final bool showDivider;

  const _MenuSection({
    required this.title,
    required this.items,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showDivider)
            const Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Divider(height: 1, color: AppTheme.surfaceGray),
            ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 14,
              height: 20 / 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ProfileMenuItem(data: item),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final _ProfileMenuData data;

  const _ProfileMenuItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.surfaceLightGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(data.icon, size: 20, color: AppTheme.textSub),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
              Text(
                data.subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  height: 16.5 / 11,
                  color: AppTheme.textHint,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, size: 16, color: AppTheme.textHint),
      ],
    );
  }
}

class _ProfileMenuData {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileMenuData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
