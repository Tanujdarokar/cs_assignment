import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  final Function(String route)? onNavigate;

  const CustomDrawer({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          // User Profile Header
          Container(
            padding: const EdgeInsets.only(
              top: 54,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundColor: Color(0xFFFACC15),
                  child: Icon(
                    Icons.person,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Swati',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.circle,
                            size: 6,
                            color: Color(0xFFFACC15),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Personal',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFACC15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'swati@cstech.in',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Drawer List Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _buildDrawerItem(
                  icon: Icons.rocket_launch_outlined,
                  title: 'Getting Started',
                  onTap: () => onNavigate?.call('welcome'),
                ),
                _buildDrawerItem(
                  icon: Icons.cloud_sync_outlined,
                  title: 'Sync Data',
                ),
                _buildDrawerItem(
                  icon: Icons.grid_view_outlined,
                  title: 'Gamification',
                ),
                _buildDrawerItem(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'Send Logs',
                ),
                _buildDrawerItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () => onNavigate?.call('settings'),
                ),
                _buildDrawerItem(
                  icon: Icons.headset_mic_outlined,
                  title: 'Help?',
                ),
                _buildDrawerItem(
                  icon: Icons.person_remove_outlined,
                  title: 'Cancel Subscription',
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    'App Info',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),

                _buildDrawerItem(
                  icon: Icons.badge_outlined,
                  title: 'About Us',
                ),
                _buildDrawerItem(
                  icon: Icons.description_outlined,
                  title: 'Privacy Policy',
                ),
                _buildDrawerItem(
                  icon: Icons.verified_outlined,
                  title: 'Version 1.01.52',
                ),
                _buildDrawerItem(
                  icon: Icons.share_outlined,
                  title: 'Share App',
                ),
                _buildDrawerItem(
                  icon: Icons.logout_rounded,
                  title: 'Logout',
                  onTap: () => onNavigate?.call('login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            color: Color(0xFFF1F5F9),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.textPrimary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
