import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../../providers/navigation_provider.dart';

import 'home_screen.dart';
import '../chat/ask_doubt_screen.dart';
import '../mcq/daily_mcq_screen.dart';
import '../profile/profile_screen.dart';
import '../exams/tests_screen.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      const HomeScreen(),
      const AskDoubtScreen(),
      const DailyMcqScreen(),
      const TestsScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      _buildNavItem(
        title: "Home",
        icon: FontAwesomeIcons.house,
      ),
      _buildNavItem(
        title: "Doubt",
        icon: FontAwesomeIcons.circleQuestion,
      ),
      _buildNavItem(
        title: "MCQ",
        icon: FontAwesomeIcons.listCheck,
      ),
      _buildNavItem(
        title: "Live",
        icon: FontAwesomeIcons.towerBroadcast,
      ),
      _buildNavItem(
        title: "Profile",
        icon: FontAwesomeIcons.circleUser,
      ),
    ];
  }

  PersistentBottomNavBarItem _buildNavItem({
    required String title,
    required IconData icon,
  }) {
    return PersistentBottomNavBarItem(
      title: title,
      icon: FaIcon(icon, size: 18.sp),
      inactiveIcon: FaIcon(icon, size: 18.sp),
      activeColorPrimary: Colors.white,
      activeColorSecondary: Colors.white,
      inactiveColorPrimary: Colors.white54,
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    final selectedIndex = navProvider.currentIndex;

    return PopScope(
      canPop: selectedIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (selectedIndex != 0) {
          navProvider.setIndex(0);
        }
      },
      child: Scaffold(
        // appBar: _selectedIndex == 0
        //     ? null
        //     : CustomAppBar(
        //         title: _getPageTitle(_selectedIndex),
        //         actions: [
        //           IconButton(
        //             icon: const FaIcon(
        //               FontAwesomeIcons.bell,
        //               size: 18,
        //               color: AppColors.textPrimaryLight,
        //             ),
        //             onPressed: () {
        //               // TODO: Navigate to notifications
        //             },
        //           ),
        //         ],
        //       ),
        body: PersistentTabView(
          context,
          controller: navProvider.controller,
          screens: _screens,
          items: _navBarItems(),
          confineToSafeArea: true,
          backgroundColor: const Color(0xFF020617),
          navBarHeight: 70.h,
          handleAndroidBackButtonPress: false,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardAppears: true,
          popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
          animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation: ItemAnimationSettings(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
            ),
            screenTransitionAnimation: ScreenTransitionAnimationSettings(
              animateTabTransition: true,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
            ),
          ),
          decoration: NavBarDecoration(
            colorBehindNavBar: const Color(0xFF020617),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          navBarStyle: NavBarStyle.style1,
        ),
      ),
    );
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 1:
        return 'Ask Your Doubt';
      case 2:
        return 'Daily MCQ';
      case 3:
        return 'Live Classes';
      case 4:
        return 'Profile';
      default:
        return 'VLM Academy';
    }
  }
}
