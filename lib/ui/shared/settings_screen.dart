import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/animated_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Notifications Section
          Text('Notifications', style: AppTextStyles.h6),
          const SizedBox(height: 12),
          GlassmorphicCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSwitchTile(
                  'Enable Notifications',
                  'Receive updates about classes and tests',
                  _notificationsEnabled,
                  (value) => setState(() => _notificationsEnabled = value),
                  Icons.notifications_outlined,
                ),
                const Divider(),
                _buildSwitchTile(
                  'Email Notifications',
                  'Get notified via email',
                  _emailNotifications,
                  (value) => setState(() => _emailNotifications = value),
                  Icons.email_outlined,
                ),
                const Divider(),
                _buildSwitchTile(
                  'Push Notifications',
                  'Receive push notifications',
                  _pushNotifications,
                  (value) => setState(() => _pushNotifications = value),
                  Icons.phone_android,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Appearance Section
          Text('Appearance', style: AppTextStyles.h6),
          const SizedBox(height: 12),
          GlassmorphicCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSwitchTile(
                  'Dark Mode',
                  'Use dark theme',
                  _darkModeEnabled,
                  (value) => setState(() => _darkModeEnabled = value),
                  Icons.dark_mode_outlined,
                ),
                const Divider(),
                _buildOptionTile(
                  'Language',
                  _selectedLanguage,
                  Icons.language,
                  () => _showLanguageSelector(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Account Section
          Text('Account', style: AppTextStyles.h6),
          const SizedBox(height: 12),
          GlassmorphicCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildActionTile(
                  'Change Password',
                  Icons.lock_outline,
                  () {},
                ),
                const Divider(),
                _buildActionTile(
                  'Privacy Policy',
                  Icons.privacy_tip_outlined,
                  () {},
                ),
                const Divider(),
                _buildActionTile(
                  'Terms of Service',
                  Icons.description_outlined,
                  () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Danger Zone
          Text('Danger Zone', style: AppTextStyles.h6),
          const SizedBox(height: 12),
          GlassmorphicCard(
            padding: const EdgeInsets.all(16),
            child: _buildActionTile(
              'Delete Account',
              Icons.delete_outline,
              () => _showDeleteConfirmation(),
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
    IconData icon,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title, style: AppTextStyles.labelMedium),
      subtitle: Text(subtitle, style: AppTextStyles.caption),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildOptionTile(
    String title,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title, style: AppTextStyles.labelMedium),
      subtitle: Text(value, style: AppTextStyles.caption),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildActionTile(
    String title,
    IconData icon,
    VoidCallback onTap, {
    Color? color,
  }) {
    final iconColor = color ?? AppColors.primary;
    
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: AppTextStyles.labelMedium.copyWith(color: color),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select Language', style: AppTextStyles.h5),
            const SizedBox(height: 16),
            ...[
              'English',
              'Hindi',
              'Spanish',
              'French',
            ].map((lang) {
              return ListTile(
                title: Text(lang),
                trailing: _selectedLanguage == lang
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _selectedLanguage = lang);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          AnimatedButton(
            text: 'Delete',
            onPressed: () {
              // TODO: Implement account deletion
              Navigator.pop(context);
            },
            type: AnimatedButtonType.primary,
            customColor: AppColors.error,
            size: AnimatedButtonSize.small,
          ),
        ],
      ),
    );
  }
}
