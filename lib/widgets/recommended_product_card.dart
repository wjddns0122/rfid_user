import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RecommendedProductCard extends StatelessWidget {
  final String title;
  final String price;

  const RecommendedProductCard({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 131,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.surfaceLightGray,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.surfaceLightGray),
            ),
            // TODO: Replace with actual product image
            child: const Icon(Icons.image_outlined, color: AppTheme.textHint, size: 40),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textMain),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            price,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppTheme.textMain),
          ),
        ],
      ),
    );
  }
}
