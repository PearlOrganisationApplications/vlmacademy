import 'package:flutter/material.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  bool isOngoing = true;

  final List<Map<String, dynamic>> _myCourses = [
    {
      "title": "Intro to UI/UX Design",
      "category": "UI/UX Design",
      "rating": 4.4,
      "duration": "3 Hrs 06 Mins",
      "progress": 93,
      "total": 125,
      "color": Colors.tealAccent,
      "image":
          "https://img.freepik.com/free-vector/gradient-ui-ux-elements-background_23-2149056159.jpg",
    },
    {
      "title": "Wordpress website Dev..",
      "category": "Web Development",
      "rating": 3.9,
      "duration": "1 Hrs 58 Mins",
      "progress": 12,
      "total": 31,
      "color": Colors.orangeAccent,
      "image":
          "https://img.freepik.com/free-vector/wordpress-logo-concept-illustration_114360-8451.jpg",
    },
    {
      "title": "3D Blender and UI/UX",
      "category": "UI/UX Design",
      "rating": 4.6,
      "duration": "2 Hrs 46 Mins",
      "progress": 56,
      "total": 98,
      "color": Colors.blueAccent,
      "image":
          "https://img.freepik.com/free-photo/view-3d-model-with-headphones-smartphone_23-2150711906.jpg",
    },
    {
      "title": "Learn UX User Persona",
      "category": "UX/UI Design",
      "rating": 3.9,
      "duration": "1 Hrs 58 Mins",
      "progress": 25,
      "total": 60,
      "color": Colors.pinkAccent,
      "image":
          "https://img.freepik.com/free-vector/user-personas-concept-illustration_114360-15545.jpg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081426),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildHeader(),
            const SizedBox(height: 25),
            _buildSearchBar(),
            const SizedBox(height: 25),
            _buildToggleTabs(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _myCourses.length,
                itemBuilder: (context, index) {
                  return _buildCourseCard(_myCourses[index]);
                },
              ),
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
            onTap: () {
              // Usually in a dashboard, back might not be visible unless it's a subpage.
              // But the screenshot shows a back arrow.
            },
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 20),
          const Text(
            "My Courses",
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

  Widget _buildToggleTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF1B2A41),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => isOngoing = false),
                child: Container(
                  decoration: BoxDecoration(
                    color: !isOngoing
                        ? const Color(0xFF263238)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Completed",
                      style: TextStyle(
                        color: !isOngoing ? Colors.white : Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => isOngoing = true),
                child: Container(
                  decoration: BoxDecoration(
                    color: isOngoing
                        ? const Color(0xFF1ABC9C)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Ongoing",
                      style: TextStyle(
                        color: isOngoing ? Colors.white : Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    double progressPercent = course['progress'] / course['total'];
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFF1B2A41),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Course Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.network(
              course['image'],
              width: 110,
              height: 110,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 110,
                height: 110,
                color: Colors.blueGrey[800],
                child: const Icon(Icons.image, color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(width: 15),
          // Course Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course['category'],
                    style: const TextStyle(
                      color: Color(0xFF4A90E2),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        course['rating'].toString(),
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      const Text("|", style: TextStyle(color: Colors.white24)),
                      const SizedBox(width: 10),
                      Text(
                        course['duration'],
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Progress Bar Row
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progressPercent,
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.1),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(course['color']),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "${course['progress']}/${course['total']}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
