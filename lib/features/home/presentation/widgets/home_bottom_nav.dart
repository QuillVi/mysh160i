import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mymotorcycle/core/constants/app_colors.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final items = <String>[
      'assets/lottie/nav_home.json',
      'assets/lottie/nav_motorcycle.json',
      'assets/lottie/nav_search.json',
      'assets/lottie/nav_profile.json',
    ];
    final fallbackIcons = <IconData>[
      Icons.home_outlined,
      Icons.pedal_bike_outlined,
      Icons.search_outlined,
      Icons.person_outline,
    ];

    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38),
        border: Border.all(color: const Color(0xFFC8CED6), width: 1.1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 420),
              curve: Curves.easeInOutCubic,
              scale: isSelected ? 1.0 : 0.92,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 420),
                curve: Curves.easeInOutCubic,
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 360),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: AnimatedOpacity(
                    key: ValueKey('${items[index]}-$isSelected'),
                    duration: const Duration(milliseconds: 220),
                    opacity: isSelected ? 1 : 0.6,
                    child: isSelected
                        ? ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcATop,
                            ),
                            child: Lottie.asset(
                              items[index],
                              width: 40,
                              height: 40,
                              fit: BoxFit.contain,
                              animate: true,
                              repeat: true,
                            ),
                          )
                        : Icon(
                            fallbackIcons[index],
                            size: 28,
                            color: AppColors.textPrimary,
                            weight: 300,
                          ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
