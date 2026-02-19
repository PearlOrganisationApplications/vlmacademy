import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../core/theme/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import 'home_screen.dart';
import 'my_courses_screen.dart';
import 'tests_screen.dart';
import 'wallet_screen.dart';
import 'profile_screen.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  late final PersistentTabController _controller;
  late final List<Widget> _screens;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);

    _screens = const [
      HomeScreen(),
      MyCoursesScreen(),
      TestsScreen(),
      WalletScreen(),
      ProfileScreen(),
    ];

    _controller.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_selectedIndex != _controller.index) {
      setState(() {
        _selectedIndex = _controller.index;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabChange);
    _controller.dispose();
    super.dispose();
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      _buildNavItem(
        title: "HOME",
        icon: FontAwesomeIcons.house,
      ),
      _buildNavItem(
        title: "MY COURSES",
        icon: FontAwesomeIcons.bookOpen,
      ),
      PersistentBottomNavBarItem(
        title: "TESTS",
        icon: _buildCenterButton(),
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.textSecondaryLight,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
      _buildNavItem(
        title: "TRANSACTION",
        icon: FontAwesomeIcons.wallet,
      ),
      _buildNavItem(
        title: "PROFILE",
        icon: FontAwesomeIcons.user,
      ),
    ];
  }

  PersistentBottomNavBarItem _buildNavItem({
    required String title,
    required IconData icon,
  }) {
    return PersistentBottomNavBarItem(
      title: title,
      icon: FaIcon(icon, size: 20),
      activeColorPrimary: AppColors.primary,
      inactiveColorPrimary: AppColors.textSecondaryLight,
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 10,
      ),
    );
  }

  Widget _buildCenterButton() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: const Center(
        child: FaIcon(
          FontAwesomeIcons.play,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (_selectedIndex != 0) {
          _controller.jumpToTab(0);
        }
      },
      child: Scaffold(
        appBar: _selectedIndex == 0
            ? null
            : CustomAppBar(
                title: _getPageTitle(_selectedIndex),
                actions: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.bell,
                      size: 18,
                      color: AppColors.textPrimaryLight,
                    ),
                    onPressed: () {
                      // TODO: Navigate to notifications
                    },
                  ),
                ],
              ),
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _screens,
          items: _navBarItems(),
          confineToSafeArea: true,
          backgroundColor: AppColors.backgroundDark,
          navBarHeight: kBottomNavigationBarHeight,
          handleAndroidBackButtonPress: false,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardAppears: true,
          popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
          animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation: ItemAnimationSettings(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            ),
            screenTransitionAnimation: ScreenTransitionAnimationSettings(
              animateTabTransition: true,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            ),
          ),
          decoration: const NavBarDecoration(
            colorBehindNavBar: AppColors.backgroundDark,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          navBarStyle: NavBarStyle.style15,
        ),
      ),
    );
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 1:
        return 'My Courses';
      case 2:
        return 'Online Tests';
      case 3:
        return 'Transaction';
      case 4:
        return 'Profile';
      default:
        return 'VLM Academy';
    }
  }
}
