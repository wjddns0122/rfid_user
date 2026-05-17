import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'station_recognize_complete_screen.dart';

class StationRecognizeScreen extends StatefulWidget {
  const StationRecognizeScreen({super.key});

  @override
  State<StationRecognizeScreen> createState() => _StationRecognizeScreenState();
}

class _StationRecognizeScreenState extends State<StationRecognizeScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 3초 후 인식 완료 화면으로 이동
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const StationRecognizeCompleteScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('스테이션 인식 중'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            // 중앙 인식 애니메이션/아이콘 영역 목업
            Stack(
              alignment: Alignment.center,
              children: [
                // 배경 원 1 (가장 연한 색)
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryExtraLight,
                    shape: BoxShape.circle,
                  ),
                ),
                // 배경 원 2 (중간 색)
                Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryLight,
                    shape: BoxShape.circle,
                  ),
                ),
                // 중앙 아이콘 배경 (둥근 사각형)
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    // TODO: 실제 스캔 아이콘 에셋으로 교체 필요
                    child: Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            // 안내 텍스트
            Text(
              '스테이션을 인식하는 중입니다.',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              '잠시만 기다려주세요.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
