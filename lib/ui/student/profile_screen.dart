import 'package:flutter/material.dart';
import '../../data/sources/mock_data_source.dart';
import 'edit_profile_screen.dart';
import '../shared/notifications_screen.dart';
import 'rewards_center_screen.dart';
import 'wallet_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockDataSource.mockUsers[0];
    const backgroundColor = Color(0xFF030712); // Deep dark background
    const cardBorderColor = Color(0xFF3B82F6); // Vibrant blue border

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Custom App Bar
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                // Overlapping Avatar and Card Stack
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    // The Card
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF111827), // Dark navy for card
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                            color: cardBorderColor.withOpacity(0.8), width: 2),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                              height: 70), // Spacing for overlapping avatar
                          // User Name & Email
                          Text(
                            user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.email,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Menu Items
                          _buildMenuItem(Icons.person_outline, 'Edit Profile',
                              onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen()),
                            );
                          }),
                          _buildMenuItem(
                              Icons.account_balance_wallet_outlined, 'Wallet',
                              onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => const WalletScreen()),
                            );
                          }),
                          _buildMenuItem(
                              Icons.notifications_none, 'Notifications',
                              onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationsScreen()),
                            );
                          }),
                          _buildMenuItem(
                              Icons.card_giftcard_outlined, 'Rewards',
                              onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RewardsCenterScreen()),
                            );
                          }),
                          _buildMenuItem(Icons.security_outlined, 'Security',
                              onTap: () {}),
                          _buildMenuItem(
                            Icons.translate,
                            'Language',
                            trailing: 'English (US)',
                            onTap: () {},
                          ),
                          _buildMenuItem(Icons.visibility_outlined, 'Dark Mode',
                              onTap: () {}),
                          _buildMenuItem(
                              Icons.description_outlined, 'Terms & Conditions',
                              onTap: () {}),
                          _buildMenuItem(Icons.help_outline, 'Help Center',
                              onTap: () {}),
                          _buildMenuItem(Icons.mail_outline, 'Invite Friends',
                              onTap: () {}),
                          _buildMenuItem(Icons.logout, 'Logout',
                              showDivider: false, onTap: () {}),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    // The Overlapping Avatar
                    Positioned(
                      top: 0,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: cardBorderColor, width: 2),
                            ),
                            child: const CircleAvatar(
                              radius: 56,
                              backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/men/1.jpg',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFF3B82F6),
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfileScreen()),
                                );
                              },
                              child: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    String? trailing,
    bool showDivider = true,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      leading: Icon(icon, color: Colors.white.withOpacity(0.8), size: 24),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null)
            Text(
              trailing,
              style: const TextStyle(
                color: Color(0xFF3B82F6),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.white54),
        ],
      ),
      onTap: onTap,
    );
  }
}
