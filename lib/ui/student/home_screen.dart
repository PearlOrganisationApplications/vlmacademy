import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vlm_academy/ui/shared/notifications_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'course_list_screen/popular_course_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopStatusRow(),
              const SizedBox(height: 20),
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 25),
              _buildDailyRewardsCard(),
              const SizedBox(height: 25),
              _buildSectionHeader("Popular Courses", onSeeAll: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const PopularCoursesScreen(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              }),
              const SizedBox(height: 15),
              _buildCategoryPills(),
              const SizedBox(height: 15),
              _buildPopularCoursesList(),
              const SizedBox(height: 25),
              _buildSectionHeader("Ask a Teacher Instantly", onSeeAll: () {}),
              const SizedBox(height: 15),
              _buildTeachersList(),
              const SizedBox(height: 100), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildStatusBadge(
          icon: FontAwesomeIcons.bolt,
          color: Colors.amber,
          label: "Level 12",
        ),
        const SizedBox(width: 8),
        _buildStatusBadge(
          icon: FontAwesomeIcons.solidStar,
          color: AppColors.primary,
          label: "1,245 Coins",
        ),
        const SizedBox(width: 8),
        _buildStatusBadge(
          icon: FontAwesomeIcons.solidGem,
          color: Colors.cyan,
          label: "42 Gems",
        ),
      ],
    );
  }

  Widget _buildStatusBadge({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, size: 12, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textPrimaryDark,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
              child: const CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?u=harsha'),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  "Lvl 5",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("🌟", style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 5),
                  Text(
                    "Welcome Back,",
                    style: AppTextStyles.h4.copyWith(
                      color: AppColors.textPrimaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                "Explorer Harsha!",
                style: AppTextStyles.h4.copyWith(
                  color: AppColors.textPrimaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0.8,
                        backgroundColor: AppColors.surfaceDark,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primary),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "320 / 400 XP",
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondaryDark,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
        InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                  builder: (context) => const NotificationsScreen()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.borderDark.withValues(alpha: 0.5)),
            ),
            child: const Badge(
              child: FaIcon(
                FontAwesomeIcons.solidBell,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.white54,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Text(
                  "Search for..",
                  style:
                      AppTextStyles.bodyMedium.copyWith(color: Colors.white54),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const FaIcon(
            FontAwesomeIcons.sliders,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildDailyRewardsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade600,
            Colors.cyan.shade400,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Daily Rewards Section",
                  style: AppTextStyles.h4.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.hourglassHalf,
                        color: Colors.orange, size: 12),
                    SizedBox(width: 5),
                    Text(
                      "2h 14m left",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Solve 5 MCQ today and win\n50 XP",
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text("Start Quest",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white38)),
              const SizedBox(width: 4),
              Container(
                  width: 12,
                  height: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white)),
              const SizedBox(width: 4),
              Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white38)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.h5.copyWith(color: AppColors.textPrimaryDark),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: Row(
            children: [
              Text(
                "SEE ALL",
                style: AppTextStyles.buttonSmall.copyWith(
                  color: AppColors.textSecondaryDark,
                  fontSize: 10,
                ),
              ),
              const Icon(Icons.chevron_right,
                  size: 16, color: AppColors.textSecondaryDark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryPills() {
    final categories = ["All", "Physics", "Chemistry", "Arts"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isSelected = cat == "Physics";
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              gradient: isSelected ? AppColors.primaryGradient : null,
              color: isSelected ? null : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              cat,
              style: AppTextStyles.labelMedium.copyWith(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPopularCoursesList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCourseCard(
            title: "Thermodynamics",
            tag: "Heat Mastery Arena",
            reward: "120 XP",
            coins: "850 Coins",
            players: "7,030",
            imageUrl:
                "https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=500&q=80",
          ),
          const SizedBox(width: 15),
          _buildCourseCard(
            title: "Chemical Bonds",
            tag: "Chemistry",
            reward: "100 XP",
            coins: "450 Coins",
            players: "3,120",
            imageUrl:
                "https://images.unsplash.com/photo-1576086213369-97a306d36557?w=500&q=80",
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard({
    required String title,
    required String tag,
    required String reward,
    required String coins,
    required String players,
    required String imageUrl,
  }) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reward: $reward",
                      style: const TextStyle(color: Colors.amber, fontSize: 10),
                    ),
                    const Icon(Icons.bookmark_border,
                        color: Colors.white54, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Mission: $title Trial",
                  style: AppTextStyles.h6.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.circle,
                        color: Colors.grey, size: 7),
                    const SizedBox(width: 5),
                    Text(
                      coins,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(width: 15),
                    const FaIcon(FontAwesomeIcons.users,
                        color: Colors.grey, size: 10),
                    const SizedBox(width: 5),
                    Text(
                      "$players ",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeachersList() {
    final teachers = [
      {"name": "Jiya", "url": "https://i.pravatar.cc/150?u=jiya"},
      {"name": "Aman", "url": "https://i.pravatar.cc/150?u=aman"},
      {"name": "Rahul.J", "url": "https://i.pravatar.cc/150?u=rahulj"},
      {"name": "Manav", "url": "https://i.pravatar.cc/150?u=manav"},
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: teachers.map((t) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(t["url"]!),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t["name"]!,
                  style: AppTextStyles.labelSmall
                      .copyWith(color: AppColors.textPrimaryDark),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
