import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:user_rfid/screens/cart_screen.dart';
import '../services/scan_log.dart';
import '../theme/app_theme.dart';
import '../widgets/hero_banner.dart';
import '../widgets/vip_card.dart';
import '../widgets/live_cart_item.dart';
import '../widgets/service_link_card.dart';
import '../widgets/store_map_preview.dart';
import '../widgets/recommended_product_card.dart';
import '../widgets/help_bottom_sheet.dart';
import 'pickup_detail_screen.dart';
import 'delivery_tracking_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      body: Stack(
        children: [
          // Main Scrollable Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 96,
              ), // Space for floating btn
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),

                  // Content with 20px padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const HeroBanner(),
                        const SizedBox(height: 24),
                        const VipCard(),
                        const SizedBox(height: 24),

                        _buildLiveCartSection(),
                        const SizedBox(height: 24),

                        _buildServiceLinks(),
                        const SizedBox(height: 24),

                        const StoreMapPreview(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),

                  _buildRecommendedSection(),
                ],
              ),
            ),
          ),

          // Floating Helper Button
          Positioned(
            right: 20,
            bottom: 16,
            child: _buildFloatingHelperButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '김아론님',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'MEMBER ID 12345678',
                style: TextStyle(fontSize: 12, color: AppTheme.textHint),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppTheme.statusGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.notifications_none,
                size: 24,
              ), // TODO: Replace with custom SVG
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveCartSection() {
    return StreamBuilder<DatabaseEvent>(
      stream: logsRef.onValue,
      builder: (context, snapshot) {
        final scans = parseScans(snapshot.data?.snapshot);
        final totalPrice = scans.fold<int>(0, (sum, s) => sum + s.lineTotal);
        final totalQty = scans.fold<int>(0, (sum, s) => sum + s.quantity);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '라이브 카트',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textMain,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '실시간으로 담긴 상품',
                      style: TextStyle(fontSize: 12, color: AppTheme.textHint),
                    ),
                  ],
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                    ), // TODO: Replace with custom SVG
                    if (scans.isNotEmpty)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryDark,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$totalQty',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Cart Items List (RFID 실시간 스캔 1건당 1행)
            if (scans.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  '아직 인식된 상품이 없습니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppTheme.textHint),
                ),
              )
            else
              ...scans.map(
                (scan) => LiveCartItem(
                  key: ValueKey('live-${scan.key}'),
                  title: scan.name,
                  option: scan.uid,
                  price: formatWon(scan.price),
                  quantity: scan.quantity,
                  onDecrease: () {},
                  onIncrease: () {},
                  onDelete: () => removeScansByUid(scan.uid),
                ),
              ),
            const SizedBox(height: 16),
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총 $totalQty개 상품',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textMain,
                  ),
                ),
                Text(
                  formatWon(totalPrice),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textMain,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Checkout Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '결제하기',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildServiceLinks() {
    return Row(
      children: [
        Expanded(
          child: ServiceLinkCard(
            title: '픽업 조회',
            subtitle: '주문한 상품을\n픽업해보세요',
            iconData:
                Icons.shopping_bag_outlined, // TODO: Replace with custom SVG
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PickupDetailScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ServiceLinkCard(
            title: '배송 조회',
            subtitle: '주문한 상품의\n배송 상태를 확인하세요',
            iconData:
                Icons.local_shipping_outlined, // TODO: Replace with custom SVG
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeliveryTrackingScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '추천 상품',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
              Row(
                children: const [
                  Text(
                    '더보기',
                    style: TextStyle(fontSize: 12, color: AppTheme.textHint),
                  ),
                  Icon(Icons.chevron_right, size: 12, color: AppTheme.textHint),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 187,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: const [
              RecommendedProductCard(title: '오버핏 블레이저', price: '89,000원'),
              SizedBox(width: 12),
              RecommendedProductCard(title: '후드 스웨트셔츠', price: '49,000원'),
              SizedBox(width: 12),
              RecommendedProductCard(title: '와이드 데님 팬츠', price: '59,000원'),
              SizedBox(width: 12),
              RecommendedProductCard(title: '볼캡', price: '19,000원'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingHelperButton() {
    return GestureDetector(
      onTap: () => HelpBottomSheet.show(context),
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: AppTheme.accentYellow,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.qr_code_scanner, color: Colors.white, size: 24),
            SizedBox(height: 2),
            Text(
              '스캔',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
