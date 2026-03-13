import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlm_academy/core/constants/app_images.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../shared/background_screen.dart';

class StudentProfileSetupScreen extends StatefulWidget {
  const StudentProfileSetupScreen({super.key});

  @override
  State<StudentProfileSetupScreen> createState() =>
      _StudentProfileSetupScreenState();
}

class _StudentProfileSetupScreenState extends State<StudentProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the 12 fields
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _classController = TextEditingController();
  final _boardController = TextEditingController();
  final _mediumController = TextEditingController();
  final _schoolController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _parentMobileController = TextEditingController();
  final _subjectsController = TextEditingController();
  final _weakSubjectsController = TextEditingController();
  final _languageController = TextEditingController();

  @override
  void dispose() {
    for (var controller in [
      _nameController,
      _nicknameController,
      _classController,
      _boardController,
      _mediumController,
      _schoolController,
      _cityController,
      _stateController,
      _parentMobileController,
      _subjectsController,
      _weakSubjectsController,
      _languageController
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onComplete() {
    if (_formKey.currentState!.validate()) {
      // Logic to save profile would go here
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      useSafeArea: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              _buildHeader(),
              SizedBox(height: 32.h),
              _buildGlassForm(),
              SizedBox(height: 32.h),
              _buildSubmitButton(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Center(
          child: Image.asset(
            AppImages.vlmLogo,
            width: 150.w,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 40.h),
        Text(
          'Student Profile',
          style: AppTextStyles.h4
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          'Let\'s personalize your learning experience',
          style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildGlassForm() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildField(
                controller: _nameController,
                label: 'Full Name',
                hint: 'Enter your name',
                icon: Icons.person_outline),
            _buildField(
                controller: _nicknameController,
                label: 'Nickname',
                hint: 'How should we call you?',
                icon: Icons.face_outlined),
            _buildField(
                controller: _classController,
                label: 'Class',
                hint: 'e.g. 10th Standard',
                icon: Icons.school_outlined),
            _buildField(
                controller: _boardController,
                label: 'Board',
                hint: 'e.g. CBSE, ICSE',
                icon: Icons.auto_awesome_mosaic_outlined),
            _buildField(
                controller: _mediumController,
                label: 'Medium',
                hint: 'e.g. English, Hindi',
                icon: Icons.translate_outlined),
            _buildField(
                controller: _schoolController,
                label: 'School Name',
                hint: 'Your school name',
                icon: Icons.location_city_outlined),
            _buildField(
                controller: _cityController,
                label: 'City',
                hint: 'Your city',
                icon: Icons.map_outlined),
            _buildField(
                controller: _stateController,
                label: 'State',
                hint: 'Your state',
                icon: Icons.public_outlined),
            _buildField(
                controller: _parentMobileController,
                label: 'Parent Mobile',
                hint: '+91 XXXXX XXXXX',
                icon: Icons.phone_android_outlined,
                keyboardType: TextInputType.phone),
            _buildField(
                controller: _subjectsController,
                label: 'Subjects',
                hint: 'Subjects you study',
                icon: Icons.book_outlined),
            _buildField(
                controller: _weakSubjectsController,
                label: 'Weak Subjects',
                hint: 'Need help with?',
                icon: Icons.help_outline),
            _buildField(
                controller: _languageController,
                label: 'Prefered Language',
                hint: 'e.g. English',
                icon: Icons.language_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 8.h),
            child: Text(
              label,
              style: AppTextStyles.bodySmall
                  .copyWith(color: Colors.white60, fontSize: 11.sp),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white12),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: Colors.white70, size: 20.sp),
                hintText: hint,
                hintStyle:
                    AppTextStyles.bodyMedium.copyWith(color: Colors.white24),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Field required' : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: _onComplete,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        ),
        child: Text(
          'Complete Profile',
          style: AppTextStyles.buttonLarge
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
