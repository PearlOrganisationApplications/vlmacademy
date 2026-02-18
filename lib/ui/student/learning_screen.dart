import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../../data/sources/mock_data_source.dart';
import '../../data/models/course_model.dart';
import '../widgets/custom_card.dart';
import '../widgets/empty_state.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedSubject = 'All';
  final List<String> _subjects = ['All', 'Mathematics', 'Science', 'English', 'Physics', 'Chemistry'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courses = MockDataSource.mockCourses;
    final recordedCourses = courses.where((c) => c.type == CourseType.recorded).toList();
    final liveClasses = courses.where((c) => c.type == CourseType.live).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Recorded Videos'),
            Tab(text: 'Live Classes'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Subject Filter
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _subjects.length,
              itemBuilder: (context, index) {
                final subject = _subjects[index];
                final isSelected = _selectedSubject == subject;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(subject),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedSubject = subject);
                    },
                    backgroundColor: Colors.transparent,
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.textSecondaryLight,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRecordedVideos(recordedCourses),
                _buildLiveClasses(liveClasses),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordedVideos(List<CourseModel> courses) {
    if (courses.isEmpty) {
      return const EmptyState(
        icon: Icons.video_library_outlined,
        title: 'No Videos Available',
        message: 'Check back later for new content',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CustomCard(
            onTap: () {
              // Navigate to video player
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.play_circle_fill,
                          size: 64,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            Formatters.duration(course.durationMinutes),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Course Info
                Text(
                  course.title,
                  style: AppTextStyles.labelLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  course.teacherName,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        course.subject,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.remove_red_eye, size: 14, color: AppColors.textSecondaryLight),
                    const SizedBox(width: 4),
                    Text(
                      Formatters.compactNumber(course.viewCount),
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondaryLight),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.star, size: 14, color: AppColors.rewardGold),
                    const SizedBox(width: 4),
                    Text(
                      course.rating.toString(),
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondaryLight),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLiveClasses(List<CourseModel> classes) {
    if (classes.isEmpty) {
      return const EmptyState(
        icon: Icons.live_tv_outlined,
        title: 'No Live Classes',
        message: 'No upcoming live classes scheduled',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final liveClass = classes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CustomCard(
            onTap: () {
              // Navigate to live class
            },
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: AppColors.errorGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.live_tv,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'LIVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            Formatters.time(liveClass.scheduledAt ?? DateTime.now()),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        liveClass.title,
                        style: AppTextStyles.labelLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        liveClass.teacherName,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
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
}
