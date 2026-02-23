import 'package:flutter/material.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  final Map<String, bool> _settings = {
    'Special Offers': true,
    'Sound': true,
    'Vibrate': true,
    'General Notification': true,
    'Promo & Discount': true,
    'Payment Options': true,
    'App Update': true,
    'New Service Available': true,
    'New Tips Available': true,
  };

  static const Color bgColor = Color(0xFF030712);
  static const Color accentBlue = Color(0xFF3B82F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: _settings.keys.map((key) => _buildToggleItem(key)).toList(),
      ),
    );
  }

  Widget _buildToggleItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch.adaptive(
            value: _settings[title]!,
            activeColor: Colors.white,
            activeTrackColor: accentBlue,
            inactiveThumbColor: Colors.white70,
            inactiveTrackColor: Colors.white12,
            onChanged: (value) {
              setState(() {
                _settings[title] = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
