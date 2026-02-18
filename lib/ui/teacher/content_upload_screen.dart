import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/animated_button.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/custom_text_field.dart';

class ContentUploadScreen extends StatefulWidget {
  const ContentUploadScreen({super.key});

  @override
  State<ContentUploadScreen> createState() => _ContentUploadScreenState();
}

class _ContentUploadScreenState extends State<ContentUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _contentType = 'video';
  String? _selectedSubject;
  String? _selectedClass;
  File? _selectedFile;
  File? _thumbnail;
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  final List<String> _subjects = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'English',
  ];
  
  final List<String> _classes = ['6', '7', '8', '9', '10', '11', '12'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    
    if (_contentType == 'video') {
      final video = await picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        setState(() => _selectedFile = File(video.path));
      }
    } else {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() => _selectedFile = File(image.path));
      }
    }
  }

  Future<void> _pickThumbnail() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _thumbnail = File(image.path));
    }
  }

  Future<void> _uploadContent() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file')),
      );
      return;
    }

    setState(() => _isUploading = true);

    // Simulate upload progress
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() => _uploadProgress = i / 100);
    }

    setState(() => _isUploading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Content uploaded successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Content'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Content Type Selection
            Text('Content Type', style: AppTextStyles.h6),
            const SizedBox(height: 12),
            GlassmorphicCard(
              child: Row(
                children: [
                  Expanded(
                    child: _buildTypeChip('Video', 'video', Icons.video_library),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTypeChip('PDF', 'pdf', Icons.picture_as_pdf),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTypeChip('Notes', 'notes', Icons.note),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Title
            CustomTextField(
              label: 'Title',
              hint: 'Enter content title',
              controller: _titleController,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Title is required' : null,
            ),
            const SizedBox(height: 16),

            // Description
            CustomTextField(
              label: 'Description',
              hint: 'Enter content description',
              controller: _descriptionController,
              maxLines: 4,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Description is required' : null,
            ),
            const SizedBox(height: 16),

            // Subject Selection
            Text('Subject', style: AppTextStyles.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _subjects.map((subject) {
                final isSelected = _selectedSubject == subject;
                return ChoiceChip(
                  label: Text(subject),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => _selectedSubject = selected ? subject : null);
                  },
                  selectedColor: AppColors.teacherColor,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimaryLight,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Class Selection
            Text('Class', style: AppTextStyles.labelLarge),
            const SizedBox(height: 8),
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
                  selectedColor: AppColors.teacherColor,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimaryLight,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // File Upload
            Text('Upload File', style: AppTextStyles.h6),
            const SizedBox(height: 12),
            GlassmorphicCard(
              onTap: _pickFile,
              child: Column(
                children: [
                  Icon(
                    _selectedFile != null
                        ? Icons.check_circle
                        : Icons.cloud_upload,
                    size: 60,
                    color: _selectedFile != null
                        ? AppColors.success
                        : AppColors.textSecondaryLight,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _selectedFile != null
                        ? 'File selected'
                        : 'Tap to select file',
                    style: AppTextStyles.labelMedium,
                  ),
                  if (_selectedFile != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _selectedFile!.path.split('/').last,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Thumbnail Upload (for videos)
            if (_contentType == 'video') ...[
              Text('Thumbnail (Optional)', style: AppTextStyles.h6),
              const SizedBox(height: 12),
              GlassmorphicCard(
                onTap: _pickThumbnail,
                child: Column(
                  children: [
                    Icon(
                      _thumbnail != null
                          ? Icons.image
                          : Icons.add_photo_alternate,
                      size: 40,
                      color: _thumbnail != null
                          ? AppColors.success
                          : AppColors.textSecondaryLight,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _thumbnail != null
                          ? 'Thumbnail selected'
                          : 'Add thumbnail',
                      style: AppTextStyles.labelMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Upload Progress
            if (_isUploading) ...[
              Text('Uploading...', style: AppTextStyles.h6),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _uploadProgress,
                  backgroundColor: AppColors.borderLight,
                  valueColor: const AlwaysStoppedAnimation(AppColors.teacherColor),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${(_uploadProgress * 100).toInt()}%',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.teacherColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
            ],

            // Upload Button
            AnimatedButton(
              text: 'Upload Content',
              onPressed: _isUploading ? null : _uploadContent,
              type: AnimatedButtonType.gradient,
              gradient: AppColors.teacherGradient,
              fullWidth: true,
              size: AnimatedButtonSize.large,
              icon: Icons.upload,
              isLoading: _isUploading,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(String label, String value, IconData icon) {
    final isSelected = _contentType == value;
    
    return InkWell(
      onTap: () => setState(() => _contentType = value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.teacherColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.teacherColor
                : AppColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.teacherColor
                  : AppColors.textSecondaryLight,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected
                    ? AppColors.teacherColor
                    : AppColors.textSecondaryLight,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
