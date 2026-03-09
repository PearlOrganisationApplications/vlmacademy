import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/services/onboarding_service.dart';

class DocumentVerificationStep extends StatefulWidget {
  final VoidCallback onNext;

  const DocumentVerificationStep({super.key, required this.onNext});

  @override
  State<DocumentVerificationStep> createState() =>
      _DocumentVerificationStepState();
}

class _DocumentVerificationStepState extends State<DocumentVerificationStep> {
  late OnboardingService _onboardingService;
  bool _isInitialized = false;

  Map<String, List<String>> _uploadedFiles = {
    'degree': [],
    'identity': [],
    'experience': [],
  };

  @override
  void initState() {
    super.initState();
    _initService();
  }

  Future<void> _initService() async {
    _onboardingService = await OnboardingService.init();
    setState(() {
      _uploadedFiles['degree'] = _onboardingService.getDocuments('degree');
      _uploadedFiles['identity'] = _onboardingService.getDocuments('identity');
      _uploadedFiles['experience'] =
          _onboardingService.getDocuments('experience');
      _isInitialized = true;
    });
  }

  Future<void> _pickFiles(String category) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      for (var path in result.paths) {
        if (path != null) {
          await _onboardingService.addDocument(category, path);
        }
      }
      setState(() {
        _uploadedFiles[category] = _onboardingService.getDocuments(category);
      });
    }
  }

  void _removeFile(String category, String path) async {
    await _onboardingService.removeDocument(category, path);
    setState(() {
      _uploadedFiles[category] = _onboardingService.getDocuments(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expert Verification',
            style: AppTextStyles.h4.copyWith(
              color: AppColors.textPrimaryDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Upload your credentials to start your teaching journey.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryDark,
            ),
          ),
          SizedBox(height: 32.h),
          _buildDocUploadItem(
            category: 'degree',
            title: 'Highest Educational Degree',
            subtitle: 'PDF or Image (Max 5MB)',
          ),
          SizedBox(height: 16.h),
          _buildDocUploadItem(
            category: 'identity',
            title: 'Identity Proof (Aadhar/PAN)',
            subtitle: 'Front & Back Required',
          ),
          SizedBox(height: 16.h),
          _buildDocUploadItem(
            category: 'experience',
            title: 'Experience Certificate / CV',
            subtitle: 'Optional but recommended',
          ),
          SizedBox(height: 32.h),
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: const Color(0xFF064E3B).withOpacity(0.3),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.accent.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.verified_user_outlined,
                    color: AppColors.accent, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Your documents are encrypted and only visible to the verification board.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.accent,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: widget.onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NEXT: SCHEDULE INTERVIEW',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildDocUploadItem({
    required String category,
    required String title,
    required String subtitle,
  }) {
    final files = _uploadedFiles[category] ?? [];
    final isUploaded = files.isNotEmpty;

    return Column(
      children: [
        GestureDetector(
          onTap: () => _pickFiles(category),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isUploaded
                    ? AppColors.accent
                    : Colors.white.withOpacity(0.05),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: isUploaded
                        ? AppColors.accent.withOpacity(0.1)
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.description_outlined,
                    color: isUploaded
                        ? AppColors.accent
                        : AppColors.textSecondaryDark,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textPrimaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondaryDark,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isUploaded
                      ? Icons.check_circle_outline
                      : Icons.file_upload_outlined,
                  color: isUploaded ? AppColors.accent : AppColors.primary,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
        if (files.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: files.map((path) {
              final fileName = path.split(Platform.pathSeparator).last;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.accent.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      fileName,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.accent,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    GestureDetector(
                      onTap: () => _removeFile(category, path),
                      child: Icon(Icons.close,
                          color: AppColors.accent, size: 14.sp),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
