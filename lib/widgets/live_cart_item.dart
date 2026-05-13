import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LiveCartItem extends StatelessWidget {
  final String title;
  final String option;
  final String price;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const LiveCartItem({
    super.key,
    required this.title,
    required this.option,
    required this.price,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.surfaceLightGray)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                // Product Image Placeholder
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // TODO: Add actual product image
                  child: const Icon(Icons.image_outlined, color: AppTheme.textHint), 
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title, 
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textMain),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        option, 
                        style: const TextStyle(fontSize: 10, color: AppTheme.textHint),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(price, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              // Quantity Control
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.borderGray),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: onDecrease,
                      child: Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        child: const Text('-', style: TextStyle(fontSize: 12, color: AppTheme.textHint)),
                      ),
                    ),
                    Container(
                      width: 24,
                      alignment: Alignment.center,
                      child: Text('$quantity', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                    ),
                    InkWell(
                      onTap: onIncrease,
                      child: Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        child: const Text('+', style: TextStyle(fontSize: 12, color: AppTheme.textHint)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.delete_outline, size: 16, color: AppTheme.textHint), // TODO: Replace with custom SVG
            ],
          ),
        ],
      ),
    );
  }
}
