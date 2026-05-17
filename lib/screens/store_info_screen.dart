import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class StoreInfoScreen extends StatelessWidget {
  const StoreInfoScreen({super.key});

  static const _purple = Color(0xFF6347D1);
  static const _green = Color(0xFF22C55E);
  static const _gray50 = Color(0xFFF9FAFB);
  static const _gray100 = Color(0xFFF3F4F6);
  static const _gray200 = Color(0xFFE5E7EB);
  static const _gray500 = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 3),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    _SearchSection(),
                    _FloorSelector(),
                    _MapSection(),
                    _PopularProductsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: SizedBox(
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Text(
              '매장 정보',
              style: TextStyle(
                fontSize: 18,
                height: 28 / 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {},
                icon: const Icon(Icons.notifications_none, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _gray200)),
      ),
      child: Row(
        children: const [
          Expanded(child: _StoreTab(label: '매장 지도', selected: true)),
          Expanded(child: _StoreTab(label: '상품 정보')),
        ],
      ),
    );
  }
}

class _StoreTab extends StatelessWidget {
  final String label;
  final bool selected;

  const _StoreTab({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 13),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: selected ? StoreInfoScreen._purple : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: selected ? FontWeight.bold : FontWeight.w500,
          color: selected ? StoreInfoScreen._purple : AppTheme.textHint,
        ),
      ),
    );
  }
}

class _SearchSection extends StatelessWidget {
  const _SearchSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: StoreInfoScreen._gray100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, size: 20, color: Color(0xFF9CA3AF)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '상품명, 카테고리, 브랜드 검색',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: StoreInfoScreen._gray500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: StoreInfoScreen._gray200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.tune, size: 20, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              SizedBox(
                width: 22,
                height: 22,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: StoreInfoScreen._purple,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Icon(Icons.check, size: 16, color: Colors.white),
                ),
              ),
              SizedBox(width: 8),
              Text(
                '재고 있는 상품만 보기',
                style: TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.info_outline, size: 14, color: Color(0xFF9CA3AF)),
            ],
          ),
        ],
      ),
    );
  }
}

class _FloorSelector extends StatelessWidget {
  const _FloorSelector();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Row(
            children: [
              Text(
                '스테이션 게이트 홍대점',
                style: TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, size: 18),
            ],
          ),
          Row(
            children: [
              Text(
                '층 선택',
                style: TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  color: StoreInfoScreen._gray500,
                ),
              ),
              SizedBox(width: 8),
              _FloorChip(label: '3F', selected: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _MapSection extends StatelessWidget {
  const _MapSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 5,
            child: Container(
              decoration: BoxDecoration(
                color: StoreInfoScreen._gray50,
                border: Border.all(color: StoreInfoScreen._gray100),
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: const [
                  _MapRooms(),
                  _FloorSidebar(),
                  _ProductTooltip(),
                  Align(
                    alignment: Alignment(0.05, 0.18),
                    child: _LocationPulse(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: StoreInfoScreen._gray200),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: const [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '선택한 상품 위치',
                        style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '3F 남성 캐주얼존 A-23',
                        style: TextStyle(
                          fontSize: 14,
                          height: 20 / 14,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ],
                  ),
                ),
                _DetailLocationButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapRooms extends StatelessWidget {
  const _MapRooms();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;
            return Stack(
              children: [
                _Room(
                  label: '남성 캐주얼',
                  left: 0,
                  top: 0,
                  width: w * 0.48,
                  height: h * 0.14,
                ),
                _Room(
                  label: '여성 캐주얼',
                  left: w * 0.52,
                  top: 0,
                  width: w * 0.48,
                  height: h * 0.14,
                ),
                _Room(
                  label: '피팅룸',
                  left: 0,
                  top: h * 0.18,
                  width: w * 0.28,
                  height: h * 0.18,
                ),
                _Room(
                  label: '신발',
                  left: w * 0.31,
                  top: h * 0.18,
                  width: w * 0.28,
                  height: h * 0.18,
                ),
                _Room(
                  label: '엘리베이터',
                  left: w * 0.62,
                  top: h * 0.18,
                  width: w * 0.38,
                  height: h * 0.18,
                ),
                _Room(
                  label: '액세서리',
                  left: 0,
                  top: h * 0.39,
                  width: w * 0.28,
                  height: h * 0.18,
                ),
                _Room(
                  label: '에스컬레이터',
                  left: w * 0.31,
                  top: h * 0.39,
                  width: w * 0.28,
                  height: h * 0.18,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Room extends StatelessWidget {
  final String label;
  final double left;
  final double top;
  final double width;
  final double height;

  const _Room({
    required this.label,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          border: Border.all(color: StoreInfoScreen._gray200),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 10,
            height: 15 / 10,
            color: StoreInfoScreen._gray500,
          ),
        ),
      ),
    );
  }
}

class _FloorSidebar extends StatelessWidget {
  const _FloorSidebar();

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 40,
      right: 12,
      child: Column(
        children: [
          _FloorChip(label: '4F'),
          SizedBox(height: 8),
          _FloorChip(label: '3F', selected: true),
          SizedBox(height: 8),
          _FloorChip(label: '2F'),
          SizedBox(height: 8),
          _FloorChip(label: '1F'),
          SizedBox(height: 8),
          _FloorChip(label: 'B1'),
        ],
      ),
    );
  }
}

class _FloorChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _FloorChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        border: selected ? Border.all(color: StoreInfoScreen._purple) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: selected ? FontWeight.bold : FontWeight.w400,
          color: selected ? StoreInfoScreen._purple : AppTheme.textHint,
        ),
      ),
    );
  }
}

class _ProductTooltip extends StatelessWidget {
  const _ProductTooltip();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 42,
      top: 92,
      width: 192,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: StoreInfoScreen._gray100),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    'assets/images/store_info/tooltip_blazer.png',
                    width: 48,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '오버핏 블레이저',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                height: 15 / 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 14,
                            color: StoreInfoScreen._purple,
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        '블랙 / L',
                        style: TextStyle(
                          fontSize: 10,
                          height: 15 / 10,
                          color: StoreInfoScreen._gray500,
                        ),
                      ),
                      Text(
                        '재고 3개',
                        style: TextStyle(
                          fontSize: 10,
                          height: 15 / 10,
                          fontWeight: FontWeight.w600,
                          color: StoreInfoScreen._green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -6),
            child: Transform.rotate(
              angle: 0.785398,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(color: StoreInfoScreen._gray100),
                    bottom: BorderSide(color: StoreInfoScreen._gray100),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationPulse extends StatelessWidget {
  const _LocationPulse();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: StoreInfoScreen._purple.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Container(
        width: 12,
        height: 12,
        decoration: const BoxDecoration(
          color: StoreInfoScreen._purple,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _DetailLocationButton extends StatelessWidget {
  const _DetailLocationButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        border: Border.all(color: StoreInfoScreen._purple),
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 16,
            color: StoreInfoScreen._purple,
          ),
          SizedBox(width: 4),
          Text(
            '상세 위치 보기',
            style: TextStyle(
              fontSize: 14,
              height: 20 / 14,
              fontWeight: FontWeight.bold,
              color: StoreInfoScreen._purple,
            ),
          ),
        ],
      ),
    );
  }
}

class _PopularProductsSection extends StatelessWidget {
  const _PopularProductsSection();

  static const _products = [
    _ProductData(
      '오버핏 블레이저',
      '89,000원',
      '재고 3개',
      'assets/images/store_info/blazer.png',
    ),
    _ProductData(
      '후드 스웨트셔츠',
      '49,000원',
      '재고 5개',
      'assets/images/store_info/hoodie.png',
    ),
    _ProductData(
      '와이드 데님 팬츠',
      '59,000원',
      '재고 2개',
      'assets/images/store_info/pants.png',
    ),
    _ProductData('볼캡', '19,000원', '재고 7개', 'assets/images/store_info/cap.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '3F 남성 캐주얼존 인기 상품',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '전체보기',
                      style: TextStyle(
                        fontSize: 12,
                        height: 16 / 12,
                        color: AppTheme.textHint,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 14,
                      color: AppTheme.textHint,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 184,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _products.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) =>
                  _ProductCard(product: _products[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final _ProductData product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ColoredBox(
                color: StoreInfoScreen._gray100,
                child: Image.asset(product.assetPath, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              height: 16.5 / 11,
              fontWeight: FontWeight.w500,
              color: AppTheme.textMain,
            ),
          ),
          Text(
            product.price,
            style: const TextStyle(
              fontSize: 11,
              height: 16.5 / 11,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            product.stock,
            style: const TextStyle(
              fontSize: 10,
              height: 15 / 10,
              color: AppTheme.textHint,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductData {
  final String title;
  final String price;
  final String stock;
  final String assetPath;

  const _ProductData(this.title, this.price, this.stock, this.assetPath);
}
