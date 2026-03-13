import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../student/notifications_settings_screen.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/animated_button.dart';
import '../shared/background_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: 'Live Class Starting Soon',
      message: 'Mathematics class with Mr. Sharma starts in 15 minutes',
      type: NotificationType.liveClass,
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      isRead: false,
      actionLabel: 'Join Now',
    ),
    NotificationItem(
      id: '2',
      title: 'Test Result Published',
      message: 'Your Mock Test #5 results are now available',
      type: NotificationType.testResult,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      actionLabel: 'View Result',
    ),
    NotificationItem(
      id: '3',
      title: 'Wallet Recharged',
      message: 'Your wallet has been credited with ₹500',
      type: NotificationType.wallet,
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: true,
    ),
    NotificationItem(
      id: '4',
      title: 'Daily Reward Earned!',
      message: 'You earned 50 points for maintaining your 7-day streak',
      type: NotificationType.reward,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    NotificationItem(
      id: '5',
      title: 'New Course Available',
      message: 'Advanced Physics course is now available in your library',
      type: NotificationType.course,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return BackgroundScreen(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white70),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsSettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(
                    Icons.notifications_off_outlined,
                    size: 80,
                    color: AppColors.textSecondaryLight,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Notifications',
                    style: AppTextStyles.h5.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'re all caught up!',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                if (unreadCount > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.circle,
                            size: 8, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          '$unreadCount unread notifications',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      return _buildNotificationCard(_notifications[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassmorphicCard(
        opacity: notification.isRead ? 0.05 : 0.15,
        onTap: () {
          setState(() {
            notification.isRead = true;
          });
          // Handle notification tap
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: _getGradientForType(notification.type),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIconForType(notification.type),
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: AppTextStyles.labelLarge.copyWith(
                            fontWeight: notification.isRead
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.textSecondaryLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getTimeAgo(notification.timestamp),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                      if (notification.actionLabel != null) ...[
                        const Spacer(),
                        AnimatedButton(
                          text: notification.actionLabel!,
                          onPressed: () {},
                          type: AnimatedButtonType.primary,
                          size: AnimatedButtonSize.small,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.liveClass:
        return Icons.live_tv;
      case NotificationType.testResult:
        return Icons.quiz;
      case NotificationType.wallet:
        return Icons.account_balance_wallet;
      case NotificationType.reward:
        return Icons.stars;
      case NotificationType.course:
        return Icons.school;
      case NotificationType.doubt:
        return Icons.chat_bubble;
      case NotificationType.general:
        return Icons.notifications;
    }
  }

  Gradient _getGradientForType(NotificationType type) {
    switch (type) {
      case NotificationType.liveClass:
        return AppColors.errorGradient;
      case NotificationType.testResult:
        return AppColors.secondaryGradient;
      case NotificationType.wallet:
        return AppColors.walletGradient;
      case NotificationType.reward:
        return AppColors.rewardGradient;
      case NotificationType.course:
        return AppColors.primaryGradient;
      case NotificationType.doubt:
        return AppColors.successGradient;
      case NotificationType.general:
        return AppColors.primaryGradient;
    }
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return Formatters.date(timestamp);
    }
  }
}

enum NotificationType {
  liveClass,
  testResult,
  wallet,
  reward,
  course,
  doubt,
  general,
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  bool isRead;
  final String? actionLabel;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.actionLabel,
  });
}
