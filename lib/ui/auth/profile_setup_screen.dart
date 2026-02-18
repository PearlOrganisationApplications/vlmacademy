import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/validators.dart';
import '../../core/routes/app_routes.dart';
import '../widgets/animated_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/glassmorphic_card.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String phoneNumber;
  final String userRole; // 'student' or 'teacher'

  const ProfileSetupScreen({
    super.key,
    required this.phoneNumber,
    required this.userRole,
  });

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  
  int _currentStep = 0;
  
  // Student fields
  String? _selectedClass;
  String? _selectedBoard;
  List<String> _selectedSubjects = [];
  
  // Teacher fields
  List<String> _teachingSubjects = [];
  String? _experience;
  String? _qualification;

  final List<String> _classes = ['6', '7', '8', '9', '10', '11', '12'];
  final List<String> _boards = ['CBSE', 'ICSE', 'State Board', 'IB'];
  final List<String> _subjects = [
    'Mathematics',
    'Science',
    'Physics',
    'Chemistry',
    'Biology',
    'English',
    'Hindi',
    'Social Science',
  ];
  final List<String> _experiences = [
    '0-1 years',
    '1-3 years',
    '3-5 years',
    '5-10 years',
    '10+ years',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 0) {
      if (_formKey.currentState!.validate()) {
        setState(() => _currentStep = 1);
      }
    } else if (_currentStep == 1) {
      if (_validateStep1()) {
        setState(() => _currentStep = 2);
      }
    } else {
      _completeSetup();
    }
  }

  bool _validateStep1() {
    if (widget.userRole == 'student') {
      if (_selectedClass == null || _selectedBoard == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select class and board')),
        );
        return false;
      }
    } else {
      if (_teachingSubjects.isEmpty || _experience == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete all fields')),
        );
        return false;
      }
    }
    return true;
  }

  void _completeSetup() {
    // TODO: Save user data
    if (widget.userRole == 'student') {
      Navigator.pushReplacementNamed(context, AppRoutes.studentDashboard);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.teacherDashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            _buildProgressIndicator(),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _buildStepContent(),
              ),
            ),
            
            // Buttons
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Row(
        children: List.generate(3, (index) {
          final isActive = index <= _currentStep;
          final isCompleted = index < _currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primary
                          : AppColors.borderLight,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                if (index < 2) const SizedBox(width: 8),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildBasicInfo();
      case 1:
        return widget.userRole == 'student'
            ? _buildStudentInfo()
            : _buildTeacherInfo();
      case 2:
        return _buildSubjectSelection();
      default:
        return const SizedBox();
    }
  }

  Widget _buildBasicInfo() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basic Information', style: AppTextStyles.h4),
          const SizedBox(height: 8),
          Text(
            'Let\'s start with your basic details',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 32),
          
          CustomTextField(
            label: 'Full Name',
            hint: 'Enter your full name',
            controller: _nameController,
            validator: Validators.name,
            prefixIcon: Icons.person_outline,
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Email Address',
            hint: 'Enter your email',
            controller: _emailController,
            validator: Validators.email,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
          ),
          const SizedBox(height: 16),
          
          CustomTextField(
            label: 'Phone Number',
            hint: widget.phoneNumber,
            enabled: false,
            prefixIcon: Icons.phone_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildStudentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Academic Details', style: AppTextStyles.h4),
        const SizedBox(height: 8),
        Text(
          'Help us personalize your learning experience',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 32),
        
        Text('Select Your Class', style: AppTextStyles.labelLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _classes.map((cls) {
            final isSelected = _selectedClass == cls;
            return ChoiceChip(
              label: Text('Class $cls'),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedClass = selected ? cls : null);
              },
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimaryLight,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        
        Text('Select Your Board', style: AppTextStyles.labelLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _boards.map((board) {
            final isSelected = _selectedBoard == board;
            return ChoiceChip(
              label: Text(board),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedBoard = selected ? board : null);
              },
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimaryLight,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTeacherInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Professional Details', style: AppTextStyles.h4),
        const SizedBox(height: 8),
        Text(
          'Tell us about your teaching experience',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 32),
        
        Text('Teaching Experience', style: AppTextStyles.labelLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _experiences.map((exp) {
            final isSelected = _experience == exp;
            return ChoiceChip(
              label: Text(exp),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _experience = selected ? exp : null);
              },
              selectedColor: AppColors.teacherColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimaryLight,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        
        CustomTextField(
          label: 'Highest Qualification',
          hint: 'e.g., M.Sc, B.Ed, PhD',
          onChanged: (value) => _qualification = value,
          prefixIcon: Icons.school_outlined,
        ),
      ],
    );
  }

  Widget _buildSubjectSelection() {
    final subjects = widget.userRole == 'student'
        ? _selectedSubjects
        : _teachingSubjects;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.userRole == 'student'
              ? 'Select Your Subjects'
              : 'Subjects You Teach',
          style: AppTextStyles.h4,
        ),
        const SizedBox(height: 8),
        Text(
          widget.userRole == 'student'
              ? 'Choose subjects you want to learn'
              : 'Select subjects you can teach',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 32),
        
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _subjects.map((subject) {
            final isSelected = subjects.contains(subject);
            return FilterChip(
              label: Text(subject),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    subjects.add(subject);
                  } else {
                    subjects.remove(subject);
                  }
                });
              },
              selectedColor: widget.userRole == 'student'
                  ? AppColors.primary
                  : AppColors.teacherColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimaryLight,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          if (_currentStep > 0)
            Expanded(
              child: AnimatedButton(
                text: 'Back',
                onPressed: () {
                  setState(() => _currentStep--);
                },
                type: AnimatedButtonType.outline,
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: AnimatedButton(
              text: _currentStep == 2 ? 'Complete' : 'Next',
              onPressed: _nextStep,
              type: AnimatedButtonType.gradient,
              gradient: widget.userRole == 'student'
                  ? AppColors.studentGradient
                  : AppColors.teacherGradient,
              suffixIcon: _currentStep == 2 ? Icons.check : Icons.arrow_forward,
            ),
          ),
        ],
      ),
    );
  }
}
