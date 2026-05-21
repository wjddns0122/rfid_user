import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class PickupDetailScreen extends StatelessWidget {
  const PickupDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ), // TODO: Replace with custom SVG
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '픽업 상세',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatusSection(),
            Container(height: 8, color: AppTheme.surfaceLightGray),
            _buildOrderDetailsSection(),
            Container(height: 8, color: AppTheme.surfaceLightGray),
            _buildItemsSection(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildActionButton(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '픽업 준비 완료',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '매장에 방문하여 상품을 픽업해주세요.',
                  style: TextStyle(fontSize: 14, color: AppTheme.textHint),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: 40,
                color: Colors.black,
              ), // TODO: Replace with custom SVG
              Positioned(
                right: -4,
                bottom: -4,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    size: 20,
                    color: Colors.black,
                  ), // TODO: Replace with custom SVG
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildInfoRow('주문번호', 'SG250508172941', isBoldValue: true),
          const SizedBox(height: 16),
          _buildInfoRow('주문일', '2024.05.08 (수)', isBoldValue: true),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppTheme.surfaceLightGray, height: 1),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '픽업 장소',
                style: TextStyle(fontSize: 14, color: AppTheme.textHint),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '스테이션 게이트 홍대점',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    '서울 마포구 양화로 188 AK 플라자 3F',
                    style: TextStyle(fontSize: 12, color: AppTheme.textHint),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    '운영시간 10:00 - 21:00',
                    style: TextStyle(fontSize: 12, color: AppTheme.textSub),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.borderGray),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: AppTheme.primaryDark,
                        ), // TODO: Replace with custom SVG
                        SizedBox(width: 4),
                        Text(
                          '매장 위치 보기',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppTheme.surfaceLightGray, height: 1),
          ),
          _buildInfoRow('픽업 가능 기간', '05.10 (금) ~ 05.17 (금)', isBoldValue: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBoldValue = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppTheme.textHint),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildItemsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '상품 2개',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildProductItem(
            title: '오버핏 블레이저',
            option: '블랙 / L',
            price: '89,000원',
          ),
          const SizedBox(height: 16),
          _buildProductItem(
            title: '후드 스웨트셔츠',
            option: '오트밀 / M',
            price: '49,000원',
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem({
    required String title,
    required String option,
    required String price,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 96,
          decoration: BoxDecoration(
            color: AppTheme.surfaceLightGray,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.borderGray),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            AppTheme.getProductImageUrl(title),
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppTheme.primary.withValues(alpha: 0.5),
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.image_outlined,
              color: AppTheme.textHint,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                option,
                style: const TextStyle(fontSize: 12, color: AppTheme.textHint),
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.primaryDark,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        '픽업 완료하기',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
