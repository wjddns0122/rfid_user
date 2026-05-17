import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'main_screen.dart';

class StationRecognizeCompleteScreen extends StatelessWidget {
  const StationRecognizeCompleteScreen({super.key});

  void _goHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    const _RecognitionSuccessGraphic(),
                    const SizedBox(height: 48),
                    const Text(
                      '스테이션 인식되었습니다.',
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
                      '알pos를 가져가주세요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const Spacer(flex: 4),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: FilledButton(
                  onPressed: () => _goHome(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF6347D1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      height: 1.55,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('확인'),
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
      height: 56,
      child: Row(
        children: [
          const SizedBox(width: 16),
          IconButton(
            onPressed: () => _goHome(context),
            icon: const Icon(Icons.arrow_back_ios_new, size: 22),
            color: const Color(0xFF111827),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 56),
              child: Text(
                '스테이션 인식 완료',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.55,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecognitionSuccessGraphic extends StatelessWidget {
  const _RecognitionSuccessGraphic();

  static const _purple = Color(0xFF6347D1);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const _ConfettiDot(left: 69, top: 23, size: 6),
          const _ConfettiDot(left: 49, top: 53, size: 4),
          const _ConfettiDot(left: 59, top: 123, size: 6),
          const _ConfettiDot(right: 69, top: 13, size: 6),
          const _ConfettiDot(right: 39, top: 63, size: 5),
          const _ConfettiDot(right: 59, top: 133, size: 6),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: _purple,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.check, size: 82, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _ConfettiDot extends StatelessWidget {
  const _ConfettiDot({
    this.left,
    this.right,
    required this.top,
    required this.size,
  });

  final double? left;
  final double? right;
  final double top;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: size,
          height: size,
          color: const Color(0x996347D1),
        ),
      ),
    );
  }
}
