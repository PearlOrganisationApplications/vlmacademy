import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../data/models/course_model.dart';
import '../../../core/theme/app_colors.dart';
import '../wallet/payment_methods_screen.dart';
import '../../shared/background_screen.dart';

class CourseDetailsScreen extends StatefulWidget {
  final CourseModel course;

  const CourseDetailsScreen({super.key, required this.course});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  bool _isAboutTab = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081426),
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildUnifiedDetailsCard(),
                const SizedBox(height: 100), // Spacing for bottom button
              ],
            ),
          ),

          // Top Navigation Bar (Back and Bookmark)
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 20),
                  ),
                ),
                if (!_isAboutTab) ...[
                  const SizedBox(width: 15),
                  const Text(
                    "Curriculum",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const Spacer(),
                if (_isAboutTab)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.course.isSaved
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),

          // Bottom Enroll Button
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: _buildEnrollButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        children: [
          // Course Image
          Positioned.fill(
            child: widget.course.thumbnailUrl != null
                ? Image.network(
                    widget.course.thumbnailUrl!,
                    fit: BoxFit.cover,
                  )
                : Container(color: Colors.blueGrey[900]),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    const Color(0xFF081426),
                  ],
                ),
              ),
            ),
          ),
          // Play Button
          Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.6),
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.5), width: 2),
              ),
              child:
                  const Icon(Icons.play_arrow, color: Colors.white, size: 40),
            ),
          ),
          // Title on Image
          Positioned(
            bottom: 80,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.course.title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnifiedDetailsCard() {
    return Transform.translate(
      offset: const Offset(0, -60),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1B2A41),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Info Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.course.subject,
                  style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      widget.course.rating.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.course.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildInfoItem(Icons.collections_bookmark_outlined, "21 Class"),
                const SizedBox(width: 10),
                const Text("|", style: TextStyle(color: Colors.white54)),
                const SizedBox(width: 10),
                _buildInfoItem(Icons.access_time, "42 Hours"),
                const Spacer(),
                Text(
                  "${widget.course.price ?? 499}/-",
                  style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Tabs
            _buildTabs(),
            const SizedBox(height: 25),

            // Tab Content (Now internal to the card)
            _isAboutTab ? _buildAboutContent() : _buildCurriculumContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed accumsan ex ac urna commodo rutrum. Vestibulum Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed accumsan ex ac urna commodo rutrum. Vestibulum",
          style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
              height: 1.5),
        ),
        const SizedBox(height: 25),
        const Text(
          "Instructor",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        _buildInstructorProfile(),
        const SizedBox(height: 30),
        const Text(
          "What You'll Get",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        _buildWhatYouGetList(),
        const SizedBox(height: 30),
        _buildReviewsSection(),
      ],
    );
  }

  Widget _buildCurriculumContent() {
    final curriculumData = [
      {
        "section": "Section 01 - Introduction",
        "duration": "25 Mins",
        "lessons": [
          {
            "id": "01",
            "title": "Why Using Graphic De..",
            "duration": "15 Mins",
            "isLocked": false
          },
          {
            "id": "02",
            "title": "Setup Your Graphic De..",
            "duration": "10 Mins",
            "isLocked": false
          },
        ]
      },
      {
        "section": "Section 02 - Graphic Design",
        "duration": "55 Mins",
        "lessons": [
          {
            "id": "03",
            "title": "Take a Look Graphic De..",
            "duration": "08 Mins",
            "isLocked": true
          },
          {
            "id": "04",
            "title": "Working with Graphic De..",
            "duration": "25 Mins",
            "isLocked": true
          },
          {
            "id": "05",
            "title": "Working with Frame & Lay..",
            "duration": "12 Mins",
            "isLocked": true
          },
          {
            "id": "06",
            "title": "Using Graphic Plugins",
            "duration": "10 Mins",
            "isLocked": true
          },
        ]
      },
      {
        "section": "Section 03 - Let's Practice",
        "duration": "35 Mins",
        "lessons": [
          {
            "id": "07",
            "title": "Let's Design a Sign Up Fo..",
            "duration": "15 Mins",
            "isLocked": true
          },
          {
            "id": "08",
            "title": "Sharing work with Team",
            "duration": "20 Mins",
            "isLocked": true
          },
        ]
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: curriculumData.length,
      separatorBuilder: (context, index) => const SizedBox(height: 25),
      itemBuilder: (context, sectionIndex) {
        final section = curriculumData[sectionIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurriculumSectionHeader(
                section['section'] as String, section['duration'] as String),
            const SizedBox(height: 15),
            ...(section['lessons'] as List).map((lesson) {
              return _buildLessonItem(
                lesson['id'] as String,
                lesson['title'] as String,
                lesson['duration'] as String,
                lesson['isLocked'] as bool,
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildCurriculumSectionHeader(String title, String duration) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        Text(
          duration,
          style: const TextStyle(color: Colors.blueAccent, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildLessonItem(
      String id, String title, String duration, bool isLocked) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              // ID Circle
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    id,
                    style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              // Title and Duration
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      duration,
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Icon
              Icon(
                isLocked ? Icons.lock_outline : Icons.play_circle_fill,
                color: Colors.blueAccent,
                size: 24,
              ),
            ],
          ),
        ),
        const Divider(color: Colors.white12, height: 1),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 16),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _isAboutTab = true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: _isAboutTab ? AppColors.primaryGradient : null,
                color: _isAboutTab ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "About",
                  style: TextStyle(
                    color: _isAboutTab ? Colors.white : Colors.white54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _isAboutTab = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: !_isAboutTab ? AppColors.primaryGradient : null,
                color: !_isAboutTab ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Curriculum",
                  style: TextStyle(
                    color: !_isAboutTab ? Colors.white : Colors.white54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructorProfile() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=robert'),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Robert jr",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "Physics Teacher",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
        Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
      ],
    );
  }

  Widget _buildWhatYouGetList() {
    final items = [
      {"icon": Icons.description_outlined, "text": "25 Lessons"},
      {"icon": Icons.phone_android, "text": "Access Mobile, Desktop & TV"},
      {"icon": Icons.bar_chart, "text": "Beginner Level"},
      {"icon": Icons.audio_file_outlined, "text": "Audio Book"},
      {"icon": Icons.all_inclusive, "text": "Lifetime Access"},
      {"icon": Icons.quiz_outlined, "text": "100 Quizzes"},
      {
        "icon": Icons.workspace_premium_outlined,
        "text": "Certificate of Completion"
      },
    ];

    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              Icon(item['icon'] as IconData, color: Colors.white54, size: 20),
              const SizedBox(width: 15),
              Text(item['text'] as String,
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Reviews",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("SEE ALL >",
                  style: TextStyle(color: Colors.white54, fontSize: 12)),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildReviewItem(
          "Will",
          "https://i.pravatar.cc/150?u=will",
          "This course has been very useful. Mentor was well spoken totally loved it.",
          "4.5",
        ),
        const SizedBox(height: 20),
        _buildReviewItem(
          "Martha E. Thompson",
          "https://i.pravatar.cc/150?u=martha",
          "This course has been very useful. Mentor was well spoken totally loved it. It had fun sessions as well.",
          "4.5",
        ),
      ],
    );
  }

  Widget _buildReviewItem(
      String name, String image, String comment, String rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 18, backgroundImage: NetworkImage(image)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 12),
                  const SizedBox(width: 4),
                  Text(rating,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          comment,
          style:
              const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Icon(Icons.favorite, color: Colors.red, size: 16),
            SizedBox(width: 6),
            Text("578", style: TextStyle(color: Colors.white54, fontSize: 12)),
            SizedBox(width: 15),
            Text("2 Weeks Ago",
                style: TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 15),
        const Divider(color: Colors.white10),
      ],
    );
  }

  Widget _buildEnrollButton() {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: PaymentMethodsScreen(course: widget.course),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Text(
              "Enroll Course - ${widget.course.price ?? 499}/-",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward,
                  color: Colors.blueAccent, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
