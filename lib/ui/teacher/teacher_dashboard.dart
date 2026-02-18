import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../widgets/glassmorphic_card.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Welcome Section
          Text(
            'Welcome back, Professor!',
            style: AppTextStyles.h4,
          ),
          const SizedBox(height: 8),
          Text(
            'Here\'s your teaching overview',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 24),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Students',
                  '1,234',
                  Icons.people,
                  AppColors.primaryGradient,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Active Courses',
                  '12',
                  Icons.school,
                  AppColors.secondaryGradient,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Earnings',
                  Formatters.currency(45000),
                  Icons.account_balance_wallet,
                  AppColors.walletGradient,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Avg Rating',
                  '4.8 ⭐',
                  Icons.star,
                  AppColors.rewardGradient,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Quick Actions
          Text('Quick Actions', style: AppTextStyles.h5),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  'Upload Content',
                  Icons.upload_file,
                  AppColors.primary,
                  () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  'Start Live Class',
                  Icons.video_call,
                  AppColors.error,
                  () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  'Manage Doubts',
                  Icons.chat_bubble_outline,
                  AppColors.accent,
                  () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  'View Analytics',
                  Icons.analytics,
                  AppColors.secondary,
                  () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Today's Schedule
          Text('Today\'s Schedule', style: AppTextStyles.h5),
          const SizedBox(height: 12),
          _buildScheduleCard(
            'Mathematics - Class 10',
            '10:00 AM - 11:00 AM',
            'Live Class',
            Icons.video_call,
            AppColors.error,
          ),
          const SizedBox(height: 12),
          _buildScheduleCard(
            'Physics - Class 12',
            '2:00 PM - 3:00 PM',
            'Doubt Session',
            Icons.chat,
            AppColors.primary,
          ),
          const SizedBox(height: 12),
          _buildScheduleCard(
            'Chemistry - Class 11',
            '4:00 PM - 5:00 PM',
            'Live Class',
            Icons.video_call,
            AppColors.error,
          ),
          const SizedBox(height: 24),

          // Recent Activity
          Text('Recent Activity', style: AppTextStyles.h5),
          const SizedBox(height: 12),
          GlassmorphicCard(
            child: Column(
              children: [
                _buildActivityItem(
                  'New student enrolled',
                  'Rahul Kumar joined Mathematics course',
                  '2 hours ago',
                  Icons.person_add,
                ),
                const Divider(),
                _buildActivityItem(
                  'Content uploaded',
                  'Video: Trigonometry Basics uploaded successfully',
                  '5 hours ago',
                  Icons.upload,
                ),
                const Divider(),
                _buildActivityItem(
                  'Doubt resolved',
                  'Answered 5 student doubts in Physics',
                  '1 day ago',
                  Icons.check_circle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('New Content'),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Gradient gradient,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.h4.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: GlassmorphicCard(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: AppTextStyles.labelMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard(
    String title,
    String time,
    String type,
    IconData icon,
    Color color,
  ) {
    return GlassmorphicCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelLarge),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              type,
              style: AppTextStyles.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String description,
    String time,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelMedium),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
