import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Background Image / Pattern
          Positioned(
            right: -10,
            top: 0,
            bottom: 0,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: const BoxDecoration(
                  // TODO: Replace with actual background image from assets
                  color: Colors.black12, 
                ),
              ),
            ),
          ),
          
          // Text Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'NEW ARRIVAL',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textSub,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'SPRING COLLECTION',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textMain,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'UP TO 20% OFF',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSub,
                  ),
                ),
              ],
            ),
          ),

          // Indicators
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: index == 1 ? AppTheme.textMain : AppTheme.borderGray,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
