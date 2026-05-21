import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HeroBanner extends StatefulWidget {
  const HeroBanner({super.key});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  static const List<_HeroSlideData> _slides = [
    _HeroSlideData(
      subtitle: 'NEW ARRIVAL',
      title: 'SPRING COLLECTION',
      promo: '봄 신상 단독 20% 특별 할인',
      imageUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=800',
    ),
    _HeroSlideData(
      subtitle: 'RFID SMART PICKUP',
      title: '대기 없는 1초 픽업',
      promo: '장바구니 담고 바로 가져가세요',
      imageUrl: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800',
    ),
    _HeroSlideData(
      subtitle: 'EXCLUSIVE MEMBERSHIP',
      title: '멤버십 회원 단독 혜택',
      promo: '모든 구매 건 전 품목 더블 적립',
      imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=800',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Carousel Slider
            CarouselSlider(
              carouselController: _carouselController,
              items: _slides.map((slide) => _buildSlideItem(slide)).toList(),
              options: CarouselOptions(
                height: 160,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),

            // Indicator Dots
            Positioned(
              bottom: 12,
              left: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(_slides.length, (index) {
                  final isActive = _currentIndex == index;
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isActive ? 16 : 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppTheme.primary
                            : AppTheme.textHint.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlideItem(_HeroSlideData slide) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image with premium scaling
        Image.network(
          slide.imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: AppTheme.surfaceGray,
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppTheme.surfaceGray,
            child: const Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: AppTheme.textHint,
                size: 32,
              ),
            ),
          ),
        ),

        // Premium Gradient Overlay to ensure text readability on light or dark background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.white.withValues(alpha: 0.95),
                Colors.white.withValues(alpha: 0.7),
                Colors.white.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 0.45, 0.8],
            ),
          ),
        ),

        // Text Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  slide.subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                slide.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textMain,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                slide.promo,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSub,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroSlideData {
  final String subtitle;
  final String title;
  final String promo;
  final String imageUrl;

  const _HeroSlideData({
    required this.subtitle,
    required this.title,
    required this.promo,
    required this.imageUrl,
  });
}
