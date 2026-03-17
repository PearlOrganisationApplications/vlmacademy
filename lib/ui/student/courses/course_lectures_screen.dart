import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'video_player_screen.dart';
import '../profile/certificate_screen.dart';
import '../../shared/background_screen.dart';

class CourseLecturesScreen extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseLecturesScreen({super.key, required this.course});

  @override
  State<CourseLecturesScreen> createState() => _CourseLecturesScreenState();
}

class _CourseLecturesScreenState extends State<CourseLecturesScreen> {
  final List<Map<String, dynamic>> _sections = [
    {
      "title": "Section 01 - Introducation",
      "duration": "25 Mins",
      "lessons": [
        {
          "number": "01",
          "title": "Why Using Graphic De..",
          "duration": "15 Mins",
          "isLocked": false,
        },
        {
          "number": "02",
          "title": "Setup Your Graphic De..",
          "duration": "10 Mins",
          "isLocked": false,
        },
      ]
    },
    {
      "title": "Section 02 - Graphic Design",
      "duration": "55 Mins",
      "lessons": [
        {
          "number": "03",
          "title": "Take a Look Graphic De..",
          "duration": "08 Mins",
          "isLocked": true,
          "isSaved": false,
        },
        {
          "number": "04",
          "title": "Working with Graphic De..",
          "duration": "25 Mins",
          "isLocked": true,
        },
        {
          "number": "05",
          "title": "Working with Frame & Lay..",
          "duration": "12 Mins",
          "isLocked": true,
        },
        {
          "number": "06",
          "title": "Using Graphic Design..",
          "duration": "10 Mins",
          "isLocked": true,
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // Dark Navy
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                _buildHeader(),
                const SizedBox(height: 25),
                _buildSearchBar(),
                const SizedBox(height: 25),
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                    itemCount: _sections.length,
                    itemBuilder: (context, index) {
                      return _buildSection(_sections[index]);
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildStickyButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 20),
          const Text(
            "My Lectures",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFF1B2A41),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            const Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search for ...",
                  hintStyle: TextStyle(color: Colors.white38, fontSize: 16),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF007BFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.search, color: Colors.white, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                section['title'],
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                section['duration'],
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1B2A41),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: (section['lessons'] as List).map<Widget>((lesson) {
              int index = (section['lessons'] as List).indexOf(lesson);
              bool isLast = index == (section['lessons'] as List).length - 1;
              return _buildLessonItem(lesson, !isLast);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLessonItem(Map<String, dynamic> lesson, bool showDivider) {
    return GestureDetector(
      onTap: () {
        if (!lesson['isLocked']) {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: VideoPlayerScreen(
              title: lesson['title'],
            ),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      lesson['number'],
                      style: const TextStyle(
                        color: Color(0xFF007BFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lesson['duration'],
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  lesson['isLocked']
                      ? Icons.lock_outline
                      : Icons.play_circle_fill,
                  color: const Color(0xFF007BFF),
                  size: 24,
                ),
              ],
            ),
          ),
          if (showDivider)
            Container(
              height: 1,
              color: Colors.white.withValues(alpha: 0.1),
              margin: const EdgeInsets.symmetric(horizontal: 15),
            ),
        ],
      ),
    );
  }

  Widget _buildStickyButton() {
    bool isCompleted = widget.course['isCompleted'] ?? false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF1B2A41),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          if (isCompleted) {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: CertificateScreen(course: widget.course),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          } else {
            // Continue course logic
          }
        },
        child: Container(
          height: 60,
          width: double.infinity, // Ensure full-width
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3293FF), Color(0xFF71C5FF)],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3293FF).withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCompleted ? "Get Certificate" : "Continue Courses",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              if (!isCompleted) ...[
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_forward,
                      color: Color(0xFF3293FF), size: 20),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
