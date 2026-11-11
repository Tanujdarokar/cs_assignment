import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F6FE),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_outlined, Icons.home),
          _buildNavItem(1, Icons.badge_outlined, Icons.badge),
          // Center Floating Action Play Button
          GestureDetector(
            onTap: () => onItemTapped(2),
            child: Container(
              width: 54,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          _buildNavItem(3, Icons.phone_outlined, Icons.phone),
          _buildNavItem(4, Icons.calendar_today_outlined, Icons.calendar_today),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon) {
    final isSelected = selectedIndex == index;
    return IconButton(
      onPressed: () => onItemTapped(index),
      icon: Icon(
        isSelected ? activeIcon : icon,
        color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary,
        size: 24,
      ),
    );
  }
}
