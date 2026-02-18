import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/sources/mock_data_source.dart';
import '../../data/models/test_model.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tests = MockDataSource.mockTests;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tests'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Daily Test Section
          Text('Daily Test', style: AppTextStyles.h5),
          const SizedBox(height: 12),
          _buildTestCard(
            context,
            tests.firstWhere((t) => t.type == TestType.daily),
            AppColors.primary,
          ),
          const SizedBox(height: 24),
          
          // Mock Tests Section
          Text('Mock Tests', style: AppTextStyles.h5),
          const SizedBox(height: 12),
          CustomCard(
            child: Column(
              children: [
                _buildMockTestItem('Mathematics - Full Syllabus', '100 Questions', '3 hours', false),
                const Divider(),
                _buildMockTestItem('Science - Chapter 1-5', '50 Questions', '1.5 hours', true),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Practice Tests
          Text('Practice Tests', style: AppTextStyles.h5),
          const SizedBox(height: 12),
          CustomCard(
            child: Column(
              children: [
                _buildPracticeTestItem('Algebra - Quick Practice', '20 Questions', '30 min'),
                const Divider(),
                _buildPracticeTestItem('Physics - Mechanics', '15 Questions', '20 min'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestCard(BuildContext context, TestModel test, Color color) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.quiz, color: color, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(test.title, style: AppTextStyles.h6),
                    const SizedBox(height: 4),
                    Text(
                      test.description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoChip(Icons.help_outline, '${test.questions.length} Questions'),
              const SizedBox(width: 12),
              _buildInfoChip(Icons.access_time, '${test.durationMinutes} min'),
              const SizedBox(width: 12),
              _buildInfoChip(Icons.star_outline, '${test.totalMarks} marks'),
            ],
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Start Test',
            onPressed: () {
              // Navigate to test screen
            },
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondaryLight),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildMockTestItem(String title, String questions, String duration, bool attempted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.assignment, color: AppColors.secondary, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelMedium),
                const SizedBox(height: 4),
                Text(
                  '$questions • $duration',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          if (attempted)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Attempted',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            const Icon(Icons.chevron_right, color: AppColors.textSecondaryLight),
        ],
      ),
    );
  }

  Widget _buildPracticeTestItem(String title, String questions, String duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.edit_note, color: AppColors.accent, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelMedium),
                const SizedBox(height: 4),
                Text(
                  '$questions • $duration',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textSecondaryLight),
        ],
      ),
    );
  }
}
