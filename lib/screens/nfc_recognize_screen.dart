import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class NfcRecognizeScreen extends StatelessWidget {
  const NfcRecognizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 2),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    const _NfcPhoneGraphic(),
                    const SizedBox(height: 48),
                    const Text(
                      '핸드폰을 태그에 가까이 대주세요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textMain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'NFC 태그를 인식하면 자동으로 연결됩니다.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.62,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 22),
            color: const Color(0xFF111827),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints.tightFor(width: 32, height: 32),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 56),
              child: Text(
                'NFC 인식',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.55,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textMain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NfcPhoneGraphic extends StatelessWidget {
  const _NfcPhoneGraphic();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 256,
      height: 304,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 256,
            height: 256,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Color(0x99EFECFF), Color(0x80F8F8FF)],
              ),
            ),
          ),
          const Positioned(
            top: 40,
            child: Icon(Icons.nfc, size: 40, color: Color(0xFF4F46E5)),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 128,
              height: 240,
              padding: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: const Color(0xFF111827), width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.topCenter,
              child: Container(
                width: 56,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF111827),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
