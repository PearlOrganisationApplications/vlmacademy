import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/user_model.dart';
import '../widgets/custom_button.dart';
import '../student/student_dashboard.dart';
import '../teacher/teacher_dashboard.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  UserRole? _selectedRole;

  void _handleContinue() {
    if (_selectedRole == null) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => _selectedRole == UserRole.student
            ? const StudentDashboard()
            : const TeacherDashboard(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Choose Your Role',
                style: AppTextStyles.h2,
              ),
              const SizedBox(height: 8),
              Text(
                'Select how you want to use VLM Academy',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Column(
                  children: [
                    _RoleCard(
                      icon: Icons.school,
                      title: 'Student',
                      description: 'Learn from expert teachers, take tests, and earn rewards',
                      color: AppColors.studentColor,
                      isSelected: _selectedRole == UserRole.student,
                      onTap: () => setState(() => _selectedRole = UserRole.student),
                    ),
                    const SizedBox(height: 16),
                    _RoleCard(
                      icon: Icons.person,
                      title: 'Teacher',
                      description: 'Teach students, upload content, and earn money',
                      color: AppColors.teacherColor,
                      isSelected: _selectedRole == UserRole.teacher,
                      onTap: () => setState(() => _selectedRole = UserRole.teacher),
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: 'Continue',
                onPressed: _selectedRole != null ? _handleContinue : null,
                fullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? color : AppColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? color.withOpacity(0.1) : null,
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.h5),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.success),
          ],
        ),
      ),
    );
  }
}
