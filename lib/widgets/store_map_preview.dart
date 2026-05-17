import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StoreMapPreview extends StatelessWidget {
  const StoreMapPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('매장 지도', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
            Row(
              children: const [
                Text('더보기', style: TextStyle(fontSize: 12, color: AppTheme.textHint)),
                Icon(Icons.chevron_right, size: 12, color: AppTheme.textHint),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceGray,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.surfaceGray),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                // Mock Map UI (Grid)
                Opacity(
                  opacity: 0.6,
                  child: GridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildZone('여성 캐주얼 존'),
                      _buildZone('잡화/액세서리 존', span: 2), // Grid doesn't span easily, just mocking visuals
                      _buildZone('스포츠 존'),
                      _buildZone('남성 캐주얼 존'),
                      Container(color: Colors.white),
                      _buildZone('아우터 존'),
                      _buildZone('키즈 존'),
                      _buildZone('여성 의류 존'),
                      Container(color: Colors.white),
                      Container(color: Colors.white),
                    ],
                  ),
                ),
                
                // Map Pin
                const Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.location_on, size: 24, color: AppTheme.textMain), // TODO: Replace with custom SVG
                ),
                
                // Overlay Controls (Left)
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Row(
                    children: [
                      _buildPillButton('내 위치'),
                      const SizedBox(width: 8),
                      _buildPillButton('여성의류 존'),
                    ],
                  ),
                ),
                
                // Overlay Controls (Right)
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.fullscreen, size: 16, color: AppTheme.textMain), // TODO: Replace with custom SVG
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildZone(String text, {int span = 1}) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppTheme.textHint),
      ),
    );
  }

  Widget _buildPillButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
