import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/test_model.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/glassmorphic_card.dart';

class ExamPortalScreen extends StatefulWidget {
  final TestModel test;

  const ExamPortalScreen({
    super.key,
    required this.test,
  });

  @override
  State<ExamPortalScreen> createState() => _ExamPortalScreenState();
}

class _ExamPortalScreenState extends State<ExamPortalScreen> {
  int _currentQuestionIndex = 0;
  Map<int, String?> _answers = {};
  Set<int> _markedForReview = {};
  late Timer _timer;
  late int _remainingSeconds;
  bool _showPalette = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.test.durationMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
        
        // Alert when 5 minutes remaining
        if (_remainingSeconds == 300) {
          _showTimeAlert('5 minutes remaining!');
        }
      } else {
        _submitTest(autoSubmit: true);
      }
    });
  }

  void _showTimeAlert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.warning,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _submitTest({bool autoSubmit = false}) {
    _timer.cancel();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(autoSubmit ? 'Time Up!' : 'Submit Test'),
        content: Text(
          autoSubmit
              ? 'Your test has been auto-submitted.'
              : 'Are you sure you want to submit? You have answered ${_answers.length}/${widget.test.questions.length} questions.',
        ),
        actions: [
          if (!autoSubmit)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          AnimatedButton(
            text: 'Submit',
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close exam
              // TODO: Navigate to result screen
            },
            type: AnimatedButtonType.primary,
            size: AnimatedButtonSize.small,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.test.questions[_currentQuestionIndex];
    
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Test?'),
            content: const Text('Your progress will be lost. Are you sure?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              AnimatedButton(
                text: 'Exit',
                onPressed: () => Navigator.pop(context, true),
                type: AnimatedButtonType.primary,
                customColor: AppColors.error,
                size: AnimatedButtonSize.small,
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.test.title),
          centerTitle: true,
          actions: [
            // Timer
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _remainingSeconds < 300
                    ? AppColors.error.withOpacity(0.2)
                    : AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 18,
                    color: _remainingSeconds < 300
                        ? AppColors.error
                        : AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatTime(_remainingSeconds),
                    style: AppTextStyles.labelMedium.copyWith(
                      color: _remainingSeconds < 300
                          ? AppColors.error
                          : AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / widget.test.questions.length,
              backgroundColor: AppColors.borderLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              minHeight: 4,
            ),

            // Question Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question Number
                    Row(
                      children: [
                        Text(
                          'Question ${_currentQuestionIndex + 1}/${widget.test.questions.length}',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${question.marks} marks',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Question Text
                    GlassmorphicCard(
                      child: Text(
                        question.question,
                        style: AppTextStyles.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Options
                    ...question.options.asMap().entries.map((entry) {
                      final optionIndex = entry.key;
                      final optionText = entry.value;
                      final optionLabel = String.fromCharCode(65 + optionIndex); // A, B, C, D
                      final isSelected = _answers[_currentQuestionIndex] == optionLabel;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _answers[_currentQuestionIndex] = optionLabel;
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withOpacity(0.1)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.borderLight,
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.borderLight,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      optionLabel,
                                      style: AppTextStyles.labelMedium.copyWith(
                                        color: isSelected
                                            ? Colors.white
                                            : AppColors.textSecondaryLight,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    optionText,
                                    style: AppTextStyles.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Mark for Review
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_markedForReview.contains(_currentQuestionIndex)) {
                          _markedForReview.remove(_currentQuestionIndex);
                        } else {
                          _markedForReview.add(_currentQuestionIndex);
                        }
                      });
                    },
                    icon: Icon(
                      _markedForReview.contains(_currentQuestionIndex)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: AppColors.warning,
                    ),
                  ),

                  // Question Palette
                  IconButton(
                    onPressed: () {
                      setState(() => _showPalette = !_showPalette);
                    },
                    icon: const Icon(Icons.grid_view),
                  ),

                  const Spacer(),

                  // Previous Button
                  if (_currentQuestionIndex > 0)
                    AnimatedButton(
                      text: 'Previous',
                      onPressed: () {
                        setState(() => _currentQuestionIndex--);
                      },
                      type: AnimatedButtonType.outline,
                      size: AnimatedButtonSize.small,
                    ),
                  
                  const SizedBox(width: 8),

                  // Next/Submit Button
                  AnimatedButton(
                    text: _currentQuestionIndex == widget.test.questions.length - 1
                        ? 'Submit'
                        : 'Next',
                    onPressed: () {
                      if (_currentQuestionIndex == widget.test.questions.length - 1) {
                        _submitTest();
                      } else {
                        setState(() => _currentQuestionIndex++);
                      }
                    },
                    type: AnimatedButtonType.primary,
                    size: AnimatedButtonSize.small,
                    suffixIcon: _currentQuestionIndex == widget.test.questions.length - 1
                        ? Icons.check
                        : Icons.arrow_forward,
                  ),
                ],
              ),
            ),

            // Question Palette
            if (_showPalette)
              Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border(
                    top: BorderSide(color: AppColors.borderLight),
                  ),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: widget.test.questions.length,
                  itemBuilder: (context, index) {
                    final isAnswered = _answers.containsKey(index);
                    final isMarked = _markedForReview.contains(index);
                    final isCurrent = index == _currentQuestionIndex;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _currentQuestionIndex = index;
                          _showPalette = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? AppColors.primary
                              : isAnswered
                                  ? AppColors.success.withOpacity(0.2)
                                  : Colors.transparent,
                          border: Border.all(
                            color: isMarked
                                ? AppColors.warning
                                : isCurrent
                                    ? AppColors.primary
                                    : AppColors.borderLight,
                            width: isMarked ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: isCurrent
                                  ? Colors.white
                                  : isAnswered
                                      ? AppColors.success
                                      : AppColors.textSecondaryLight,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
