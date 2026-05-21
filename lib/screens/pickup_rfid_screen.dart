import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PickupRfidScreen extends StatefulWidget {
  const PickupRfidScreen({super.key});

  @override
  State<PickupRfidScreen> createState() => _PickupRfidScreenState();
}

class _PickupRfidScreenState extends State<PickupRfidScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _radarController;
  late int _basketNumber;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // 1~12번 중 무작위 바구니 번호 배정
    _basketNumber = _random.nextInt(12) + 1;

    // RFID 무선 주파수 신호 방출 애니메이션 (레이더 효과)
    _radarController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _radarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'RFID 픽업 인식',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    _buildIntroSection(),
                    const SizedBox(height: 32),
                    _buildRfidScanningGraphic(primaryColor),
                    const SizedBox(height: 36),
                    _buildBasketInfoCard(primaryColor),
                    const SizedBox(height: 16),
                    _buildNoticeSection(),
                  ],
                ),
              ),
            ),
            _buildBottomActionBar(primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primaryLight.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'RFID 실시간 태깅',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'RFID 캐비넷에 인식해 주세요',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.3,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '배정된 $_basketNumber번 RFID 바구니에 상품을 담아주시면\n센서가 상품의 RFID 태그를 감지하여 픽업을 완료합니다.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            color: AppTheme.textSub,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // RFID 레이더 파동 및 바구니 형상 그래픽
  Widget _buildRfidScanningGraphic(Color primaryColor) {
    return Center(
      child: SizedBox(
        width: 220,
        height: 220,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 레이더 파동 애니메이션
            AnimatedBuilder(
              animation: _radarController,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: List.generate(3, (index) {
                    final progress =
                        (_radarController.value + (index / 3)) % 1.0;
                    final size = 80.0 + (progress * 130.0);
                    final opacity = (1.0 - progress).clamp(0.0, 1.0);
                    return Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor.withValues(alpha: opacity * 0.25),
                          width: 2.0 - (progress * 1.5),
                        ),
                        color: primaryColor.withValues(alpha: opacity * 0.03),
                      ),
                    );
                  }),
                );
              },
            ),
            // 중앙 RFID 스마트 바구니 코어 그래픽
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.borderSubtle, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                Icons.shopping_basket_rounded,
                size: 46,
                color: primaryColor,
              ),
            ),
            // RFID 전파 안테나 표식
            Positioned(
              top: 36,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.wifi, size: 10, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'RFID',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
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

  // 지정 바구니 안내 카드 및 배정 정보
  Widget _buildBasketInfoCard(Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderSubtle, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // 바구니 배정 넘버 섹션
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  '나의 지정 캐비넷',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSub,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$_basketNumber',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: primaryColor,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '번 캐비넷',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 주문 및 상세 내역 리스트
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildInfoRow('주문 번호', 'SG250508172941'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: AppTheme.borderSubtle, height: 1),
                ),
                _buildInfoRow('픽업 장소', '스테이션 게이트 홍대점 (RFID 존)'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: AppTheme.borderSubtle, height: 1),
                ),
                _buildInfoRow('픽업 상태', '인식 대기 중', valueColor: primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppTheme.textSub),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppTheme.textMain,
          ),
        ),
      ],
    );
  }

  Widget _buildNoticeSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: AppTheme.textHint),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '상품에 부착된 RFID 태그 훼손 시 인식이 정상적이지 않을 수 있습니다. 인식 장애 발생 시 매장 크루에게 문의해 주세요.',
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.textHint,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(Color primaryColor) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 바구니 인식 태깅 테스트용 버튼
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppTheme.statusGreen,
                  content: Text('$_basketNumber번 캐비넷에 RFID 태그 인식이 완료되었습니다!'),
                  duration: const Duration(seconds: 2),
                ),
              );
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            style: FilledButton.styleFrom(
              fixedSize: const Size.fromHeight(56),
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: const Text(
              'RFID 캐비넷 태그 인식 완료',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
            style: OutlinedButton.styleFrom(
              fixedSize: const Size.fromHeight(56),
              side: const BorderSide(color: AppTheme.borderGray),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              '홈으로 이동',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSub,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
