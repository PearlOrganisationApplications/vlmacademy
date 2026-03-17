import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/test_model.dart';
import '../../widgets/glassmorphic_card.dart';
import '../../widgets/animated_button.dart';

class TestResultScreen extends StatelessWidget {
  final TestModel test;
  final int score;
  final int totalMarks;
  final int rank;
  final int totalStudents;

  const TestResultScreen({
    super.key,
    required this.test,
    required this.score,
    required this.totalMarks,
    required this.rank,
    required this.totalStudents,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalMarks * 100).round();
    final isPassed = percentage >= 40;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Result'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share result
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Score Card
          GlassmorphicCard(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: isPassed
                    ? AppColors.successGradient
                    : AppColors.errorGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    isPassed ? Icons.check_circle : Icons.cancel,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isPassed ? 'Congratulations!' : 'Keep Trying!',
                    style: AppTextStyles.h3.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You scored',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$score/$totalMarks',
                    style: AppTextStyles.display1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$percentage%',
                      style: AppTextStyles.h4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Rank Card
          GlassmorphicCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: AppColors.rewardGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Rank', style: AppTextStyles.labelMedium),
                      const SizedBox(height: 4),
                      Text(
                        '#$rank',
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.rewardGold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Out of $totalStudents students',
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
          const SizedBox(height: 24),

          // Performance Breakdown
          Text('Performance Analysis', style: AppTextStyles.h5),
          const SizedBox(height: 12),
          GlassmorphicCard(
            child: Column(
              children: [
                _buildStatRow(
                  'Correct Answers',
                  '${test.questions.length - 5}/${test.questions.length}',
                  AppColors.success,
                  Icons.check_circle_outline,
                ),
                const Divider(),
                _buildStatRow(
                  'Wrong Answers',
                  '5',
                  AppColors.error,
                  Icons.cancel_outlined,
                ),
                const Divider(),
                _buildStatRow(
                  'Accuracy',
                  '$percentage%',
                  AppColors.primary,
                  Icons.analytics_outlined,
                ),
                const Divider(),
                _buildStatRow(
                  'Time Taken',
                  '${test.durationMinutes - 5} min',
                  AppColors.warning,
                  Icons.timer_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Subject-wise Analysis
          Text('Subject-wise Performance', style: AppTextStyles.h5),
          const SizedBox(height: 12),
          GlassmorphicCard(
            child: Column(
              children: [
                _buildSubjectBar('Mathematics', 85, AppColors.primary),
                const SizedBox(height: 16),
                _buildSubjectBar('Physics', 70, AppColors.secondary),
                const SizedBox(height: 16),
                _buildSubjectBar('Chemistry', 60, AppColors.accent),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Question-wise Analysis
          Text('Question Analysis', style: AppTextStyles.h5),
          const SizedBox(height: 12),
          ...List.generate(
            test.questions.length > 5 ? 5 : test.questions.length,
            (index) => _buildQuestionCard(test.questions[index], index),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: AnimatedButton(
                  text: 'View Solutions',
                  onPressed: () {},
                  type: AnimatedButtonType.outline,
                  icon: Icons.lightbulb_outline,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnimatedButton(
                  text: 'Retake Test',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  type: AnimatedButtonType.gradient,
                  gradient: AppColors.primaryGradient,
                  icon: Icons.refresh,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: AppTextStyles.labelMedium),
          ),
          Text(
            value,
            style: AppTextStyles.h6.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectBar(String subject, int percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(subject, style: AppTextStyles.labelMedium),
            Text(
              '$percentage%',
              style: AppTextStyles.labelMedium.copyWith(color: color),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: AppColors.borderLight,
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(QuestionModel question, int index) {
    final isCorrect = index % 3 != 0; // Mock data
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassmorphicCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isCorrect ? Icons.check : Icons.close,
                    color: isCorrect ? AppColors.success : AppColors.error,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Question ${index + 1}',
                    style: AppTextStyles.labelLarge,
                  ),
                ),
                Text(
                  '${question.marks} marks',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              question.question,
              style: AppTextStyles.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Your Answer: ',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                Text(
                  isCorrect ? question.options[question.correctAnswerIndex] : 'B',
                  style: AppTextStyles.caption.copyWith(
                    color: isCorrect ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                if (!isCorrect) ...[
                  Text(
                    'Correct: ',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  Text(
                    question.options[question.correctAnswerIndex],
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
