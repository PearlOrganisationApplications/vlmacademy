import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/sources/mock_data_source.dart';
import '../widgets/custom_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockDataSource.mockUsers[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Edit profile
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user.name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(user.name, style: AppTextStyles.h4),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.phone ?? '',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          // Academic Info
          Text('Academic Information', style: AppTextStyles.h6),
          const SizedBox(height: 12),
          CustomCard(
            child: Column(
              children: [
                _buildInfoRow(Icons.school, 'Class', user.classLevel ?? 'N/A'),
                const Divider(),
                _buildInfoRow(Icons.book, 'Board', user.board ?? 'N/A'),
                const Divider(),
                _buildInfoRow(Icons.subject, 'Subjects', user.subjects?.join(', ') ?? 'N/A'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Settings
          Text('Settings', style: AppTextStyles.h6),
          const SizedBox(height: 12),
          CustomCard(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                _buildSettingItem(Icons.notifications_outlined, 'Notifications', () {}),
                const Divider(height: 1),
                _buildSettingItem(Icons.language, 'Language', () {}),
                const Divider(height: 1),
                _buildSettingItem(Icons.dark_mode_outlined, 'Dark Mode', () {}),
                const Divider(height: 1),
                _buildSettingItem(Icons.help_outline, 'Help & Support', () {}),
                const Divider(height: 1),
                _buildSettingItem(Icons.privacy_tip_outlined, 'Privacy Policy', () {}),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Logout Button
          CustomCard(
            child: ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: Text(
                'Logout',
                style: AppTextStyles.labelLarge.copyWith(color: AppColors.error),
              ),
              onTap: () {
                // Logout
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: AppTextStyles.labelMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondaryLight),
      title: Text(title, style: AppTextStyles.labelMedium),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondaryLight),
      onTap: onTap,
    );
  }
}
