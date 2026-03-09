import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vlm_academy/ui/shared/notifications_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'course_list_screen/popular_course_list.dart';
import 'chat/inbox_screen.dart';
import 'daily_mcq_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgimage.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
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
                  _buildDailyRewardsCard(context),
                  const SizedBox(height: 25),
                  _buildSectionHeader("Popular Courses", onSeeAll: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const PopularCoursesScreen(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  }),
                  const SizedBox(height: 15),
                  _buildCategoryPills(),
                  const SizedBox(height: 15),
                  _buildPopularCoursesList(),
                  const SizedBox(height: 25),
                  _buildSectionHeader("Ask a Teacher Instantly",
                      onSeeAll: () {}),
                  const SizedBox(height: 15),
                  _buildTeachersList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopStatusRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildStatusBadge(
            icon: FontAwesomeIcons.bolt,
            color: Colors.amber,
            label: "Class 12",
          ),
          const SizedBox(width: 8),
          _buildStatusBadge(
            icon: FontAwesomeIcons.solidStar,
            color: AppColors.primary,
            label: "1,245 XP",
          ),
          const SizedBox(width: 8),
          _buildStatusBadge(
            icon: FontAwesomeIcons.solidGem,
            color: Colors.cyan,
            label: "42 Gems",
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return _buildGlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      borderRadius: BorderRadius.circular(20),
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

  Widget _buildGlassContainer({
    required Widget child,
    required BorderRadius borderRadius,
    EdgeInsetsGeometry? padding,
    double blur = 10.0,
    double opacity = 0.1,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: borderRadius,
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
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
                  Text(
                    "Welcome Back,",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textPrimaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                "Harsha!",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.labelSmall.copyWith(
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
                    "320 / 400 VLM Points",
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
              MaterialPageRoute(builder: (context) => const InboxScreen()),
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
            child: const FaIcon(
              FontAwesomeIcons.solidCommentDots,
              color: AppColors.primary,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 10),
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
          child: _buildGlassContainer(
            borderRadius: BorderRadius.circular(15),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
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

  Widget _buildDailyRewardsCard(BuildContext context) {
    return _buildGlassContainer(
      borderRadius: BorderRadius.circular(20),
      opacity:
          0.2, // Slightly more opaque for better contrast with the blue gradient
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade600.withOpacity(0.6),
              Colors.cyan.shade400.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              "Solve 5 MCQ today and win\n50 VLM Points",
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                      builder: (context) => const DailyMcqScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                elevation: 4,
                shadowColor: Colors.amber.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          if (isSelected) {
            return Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                cat,
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildGlassContainer(
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                cat,
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.normal,
                ),
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
            reward: "120 VLM Points",
            coins: "850 XP",
            players: "7,030",
            imageUrl:
                "https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=500&q=80",
          ),
          const SizedBox(width: 15),
          _buildCourseCard(
            title: "Chemical Bonds",
            tag: "Chemistry",
            reward: "100 VLM Points",
            coins: "450 XP",
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
    return _buildGlassContainer(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25)),
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
                    child: _buildGlassContainer(
                      borderRadius: BorderRadius.circular(10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      opacity: 0.3,
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
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 10),
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
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(width: 15),
                      const FaIcon(FontAwesomeIcons.users,
                          color: Colors.grey, size: 10),
                      const SizedBox(width: 5),
                      Text(
                        "$players ",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
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
