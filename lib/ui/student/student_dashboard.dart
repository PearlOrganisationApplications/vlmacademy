import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../../data/sources/mock_data_source.dart';
import '../widgets/custom_card.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    
    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        Navigator.pushNamed(context, '/student/learning');
        break;
      case 2:
        Navigator.pushNamed(context, '/student/tests');
        break;
      case 3:
        Navigator.pushNamed(context, '/student/wallet');
        break;
      case 4:
        Navigator.pushNamed(context, '/student/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final wallet = MockDataSource.getMockWallet('1');
    final streak = MockDataSource.getMockStreak('1');
    final courses = MockDataSource.mockCourses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('VLM Academy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Text(
              'Welcome back, Rahul! 👋',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: 16),

            // Wallet & Streak Cards
            Row(
              children: [
                Expanded(
                  child: CustomCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: AppColors.walletGradient,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('Wallet', style: AppTextStyles.labelMedium),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          Formatters.currency(wallet.balance),
                          style: AppTextStyles.h4.copyWith(
                            color: AppColors.walletGreen,
                          ),
                        ),
                        Text(
                          '${wallet.rewardPoints} points',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.streakOrange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.local_fire_department,
                                color: AppColors.streakOrange,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('Streak', style: AppTextStyles.labelMedium),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${streak.currentStreak} days',
                          style: AppTextStyles.h4.copyWith(
                            color: AppColors.streakOrange,
                          ),
                        ),
                        Text(
                          'Best: ${streak.longestStreak} days',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
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
                _QuickActionCard(
                  icon: Icons.play_circle_outline,
                  label: 'Learn',
                  color: AppColors.primary,
                  onTap: () {
                    Navigator.pushNamed(context, '/student/learning');
                  },
                ),
                const SizedBox(width: 12),
                _QuickActionCard(
                  icon: Icons.quiz_outlined,
                  label: 'Tests',
                  color: AppColors.secondary,
                  onTap: () {
                    Navigator.pushNamed(context, '/student/tests');
                  },
                ),
                const SizedBox(width: 12),
                _QuickActionCard(
                  icon: Icons.live_tv,
                  label: 'Live Class',
                  color: AppColors.error,
                  onTap: () {
                    Navigator.pushNamed(context, '/student/learning');
                  },
                ),
                const SizedBox(width: 12),
                _QuickActionCard(
                  icon: Icons.chat_bubble_outline,
                  label: 'Doubts',
                  color: AppColors.accent,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Continue Learning
            Text('Continue Learning', style: AppTextStyles.h5),
            const SizedBox(height: 12),
            ...courses.map((course) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CustomCard(
                    onTap: () {},
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.title,
                                style: AppTextStyles.labelLarge,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                course.teacherName,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondaryLight,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: AppColors.textSecondaryLight,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    Formatters.duration(course.durationMinutes),
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.textSecondaryLight,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    Icons.star,
                                    size: 14,
                                    color: AppColors.rewardGold,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    course.rating.toString(),
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
                )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondaryLight,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Tests'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(
        onTap: onTap,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
