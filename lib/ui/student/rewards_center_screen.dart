import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/animated_button.dart';

class RewardsCenterScreen extends StatefulWidget {
  const RewardsCenterScreen({super.key});

  @override
  State<RewardsCenterScreen> createState() => _RewardsCenterScreenState();
}

class _RewardsCenterScreenState extends State<RewardsCenterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final int _currentPoints = 1250;
  final int _currentStreak = 7;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards Center'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Daily Rewards'),
            Tab(text: 'Leaderboard'),
            Tab(text: 'Achievements'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Points Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.rewardGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.rewardGold.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildPointsCard(
                    'Total Points',
                    _currentPoints.toString(),
                    Icons.stars,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPointsCard(
                    'Current Streak',
                    '$_currentStreak days',
                    Icons.local_fire_department,
                  ),
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDailyRewards(),
                _buildLeaderboard(),
                _buildAchievements(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
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

  Widget _buildDailyRewards() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final rewards = [10, 15, 20, 25, 30, 40, 50];
    final today = DateTime.now().weekday - 1;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Daily Login Rewards', style: AppTextStyles.h5),
        const SizedBox(height: 16),
        GlassmorphicCard(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (index) {
                  final isCompleted = index < _currentStreak;
                  final isToday = index == today;
                  
                  return Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: isCompleted
                              ? AppColors.rewardGradient
                              : null,
                          color: isCompleted
                              ? null
                              : AppColors.borderLight,
                          shape: BoxShape.circle,
                          border: isToday
                              ? Border.all(
                                  color: AppColors.primary,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Center(
                          child: isCompleted
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                )
                              : Text(
                                  '${rewards[index]}',
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        days[index],
                        style: AppTextStyles.caption.copyWith(
                          color: isToday
                              ? AppColors.primary
                              : AppColors.textSecondaryLight,
                          fontWeight: isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 16),
              if (_currentStreak < 7)
                AnimatedButton(
                  text: 'Claim Today\'s Reward',
                  onPressed: () {
                    // Claim reward
                  },
                  type: AnimatedButtonType.gradient,
                  gradient: AppColors.rewardGradient,
                  fullWidth: true,
                  icon: Icons.card_giftcard,
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        Text('Bonus Rewards', style: AppTextStyles.h5),
        const SizedBox(height: 12),
        _buildBonusCard(
          'Complete 5 Tests',
          '100 Points',
          '3/5 Completed',
          0.6,
          Icons.quiz,
          AppColors.primaryGradient,
        ),
        const SizedBox(height: 12),
        _buildBonusCard(
          'Watch 10 Videos',
          '50 Points',
          '7/10 Completed',
          0.7,
          Icons.play_circle,
          AppColors.secondaryGradient,
        ),
        const SizedBox(height: 12),
        _buildBonusCard(
          'Refer 3 Friends',
          '200 Points',
          '1/3 Completed',
          0.33,
          Icons.people,
          AppColors.successGradient,
        ),
      ],
    );
  }

  Widget _buildBonusCard(
    String title,
    String reward,
    String progress,
    double progressValue,
    IconData icon,
    Gradient gradient,
  ) {
    return GlassmorphicCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelLarge),
                const SizedBox(height: 4),
                Text(
                  progress,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: AppColors.borderLight,
                    valueColor: AlwaysStoppedAnimation(AppColors.primary),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.rewardGold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              reward,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.rewardGold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboard() {
    final leaderboard = [
      {'name': 'Rahul Sharma', 'points': 2500, 'rank': 1},
      {'name': 'Priya Patel', 'points': 2350, 'rank': 2},
      {'name': 'Amit Kumar', 'points': 2100, 'rank': 3},
      {'name': 'You', 'points': 1250, 'rank': 15},
      {'name': 'Sneha Gupta', 'points': 1200, 'rank': 16},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: leaderboard.length,
      itemBuilder: (context, index) {
        final user = leaderboard[index];
        final isCurrentUser = user['name'] == 'You';
        final rank = user['rank'] as int;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassmorphicCard(
            opacity: isCurrentUser ? 0.2 : 0.1,
            child: Row(
              children: [
                // Rank Badge
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: rank <= 3
                        ? AppColors.rewardGradient
                        : null,
                    color: rank <= 3 ? null : AppColors.borderLight,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: rank <= 3
                        ? Icon(
                            rank == 1
                                ? Icons.emoji_events
                                : rank == 2
                                    ? Icons.military_tech
                                    : Icons.workspace_premium,
                            color: Colors.white,
                            size: 24,
                          )
                        : Text(
                            '#$rank',
                            style: AppTextStyles.labelSmall.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 16),

                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'] as String,
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: isCurrentUser
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isCurrentUser
                              ? AppColors.primary
                              : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.stars,
                            size: 14,
                            color: AppColors.rewardGold,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${user['points']} points',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAchievements() {
    final achievements = [
      {
        'title': 'First Steps',
        'description': 'Complete your first test',
        'icon': Icons.flag,
        'unlocked': true,
      },
      {
        'title': 'Week Warrior',
        'description': 'Maintain 7-day streak',
        'icon': Icons.local_fire_department,
        'unlocked': true,
      },
      {
        'title': 'Perfect Score',
        'description': 'Score 100% in any test',
        'icon': Icons.star,
        'unlocked': false,
      },
      {
        'title': 'Social Butterfly',
        'description': 'Refer 5 friends',
        'icon': Icons.people,
        'unlocked': false,
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        final unlocked = achievement['unlocked'] as bool;

        return GlassmorphicCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: unlocked
                      ? AppColors.rewardGradient
                      : null,
                  color: unlocked ? null : AppColors.borderLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  achievement['icon'] as IconData,
                  size: 40,
                  color: unlocked
                      ? Colors.white
                      : AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                achievement['title'] as String,
                style: AppTextStyles.labelMedium.copyWith(
                  color: unlocked ? null : AppColors.textSecondaryLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                achievement['description'] as String,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
