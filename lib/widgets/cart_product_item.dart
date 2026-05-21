import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CartProductItem extends StatelessWidget {
  final String title;
  final String option;
  final String price;
  final int quantity;
  final bool isSelected;
  final IconData placeholderIcon;
  final Key? checkboxKey;
  final VoidCallback onToggleSelected;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const CartProductItem({
    super.key,
    required this.title,
    required this.option,
    required this.price,
    required this.quantity,
    required this.isSelected,
    required this.placeholderIcon,
    this.checkboxKey,
    required this.onToggleSelected,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32, right: 12),
          child: _SelectedCheck(
            key: checkboxKey,
            isSelected: isSelected,
            onTap: onToggleSelected,
          ),
        ),
        _ProductImagePlaceholder(title: title),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                  height: 22.5 / 15,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textMain,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                option,
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  height: 16 / 12,
                  color: AppTheme.textHint,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                  height: 22.5 / 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: _QuantityStepper(
                  quantity: quantity,
                  onDecrease: onDecrease,
                  onIncrease: onIncrease,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SelectedCheck extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectedCheck({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      checked: isSelected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.cartPrimary : Colors.white,
            border: Border.all(
              color: isSelected ? AppTheme.cartPrimary : AppTheme.borderGray,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: isSelected
              ? const Icon(Icons.check, size: 12, color: Colors.white)
              : null,
        ),
      ),
    );
  }
}

class _ProductImagePlaceholder extends StatelessWidget {
  final String title;

  const _ProductImagePlaceholder({required this.title});

  @override
  Widget build(BuildContext context) {
    final imageUrl = AppTheme.getProductImageUrl(title);
    return Container(
      width: 80,
      height: 96,
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray,
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                color: AppTheme.primary.withValues(alpha: 0.5),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.textMain.withValues(alpha: 0.9),
                    AppTheme.textSub.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),
            const Icon(Icons.image_outlined, size: 34, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const _QuantityStepper({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderGray),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            label: '−',
            color: AppTheme.textHint,
            onTap: onDecrease,
          ),
          SizedBox(
            width: 30,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 20 / 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          _StepperButton(
            label: '+',
            color: AppTheme.textMain,
            onTap: onIncrease,
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _StepperButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 28,
        height: 31,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              height: 24 / 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
