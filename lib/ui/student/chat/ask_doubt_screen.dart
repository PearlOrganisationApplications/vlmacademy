import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../../../providers/chat_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../shared/background_screen.dart';
import 'ai_chat_screen.dart';
import 'teacher_searching_screen.dart';

class AskDoubtScreen extends StatefulWidget {
  const AskDoubtScreen({super.key});

  @override
  State<AskDoubtScreen> createState() => _AskDoubtScreenState();
}

class _AskDoubtScreenState extends State<AskDoubtScreen> {
  String? _selectedSubject = 'Mathematics';
  String? _selectedChapter = 'Algebra';
  final TextEditingController _questionController = TextEditingController();
  int _selectedSessionIndex = 0;

  final List<Map<String, dynamic>> _sessionTypes = [
    {
      'label': 'AI Tutor',
      'subtitle': 'Instant Help\nfrom AI',
      'icon': Icons.smart_toy_outlined,
      'color': const Color(0xFF60A5FA),
    },
    {
      'label': 'Human Chat',
      'subtitle': 'Expert\nEducator',
      'icon': Icons.people_outline,
      'color': const Color(0xFF818CF8),
    },
    {
      'label': 'Audio Call',
      'subtitle': 'Live\nDiscussion',
      'icon': Icons.call_outlined,
      'color': const Color(0xFF2DD4BF),
    },
    {
      'label': 'Video Call',
      'subtitle': 'Personalized\nSession',
      'icon': Icons.videocam_outlined,
      'color': const Color(0xFFF472B6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      useSafeArea: false,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.white, // Fixes dropdown visibility
                      ),
                      child: _buildFormCard(),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Choose Session Type',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildSessionTypes(),
                    SizedBox(height: 32.h),
                    _buildSubmitButton(),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (Navigator.canPop(context))
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            )
          else
            SizedBox(width: 48.w), // Maintain spacing if no back button
          Text(
            'Ask Your Doubt',
            style: AppTextStyles.h4.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownLabel('Select Subject'),
          _buildDropdown(
              _selectedSubject,
              (val) => setState(() => _selectedSubject = val),
              ['Mathematics', 'Physics', 'Chemistry']),
          SizedBox(height: 20.h),
          _buildDropdownLabel('Select Chapter'),
          _buildDropdown(
              _selectedChapter,
              (val) => setState(() => _selectedChapter = val),
              ['Algebra', 'Calculus', 'Trigonometry']),
          SizedBox(height: 20.h),
          Container(
            height: 200.h,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              controller: _questionController,
              maxLines: null,
              style: TextStyle(fontSize: 15.sp, color: Colors.black87),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Type your detailed question here...',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 15.sp),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                '0 / 1000',
                style: TextStyle(color: Colors.black38, fontSize: 10.sp),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attach Image (Optional)',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Added: 0/3 images',
                  style: TextStyle(color: Colors.black54, fontSize: 11.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                  child: _buildImageButton(
                      'Take Photo', Icons.camera_alt_outlined)),
              SizedBox(width: 12.w),
              Expanded(
                  child: _buildImageButton('Upload Image', Icons.image_outlined,
                      isPrimary: true)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String? value, ValueChanged<String?> onChanged, List<String> items) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          dropdownColor: Colors.white,
          icon: Icon(Icons.keyboard_arrow_down,
              color: Colors.black54, size: 20.sp),
          items: items
              .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e,
                      style:
                          TextStyle(fontSize: 15.sp, color: Colors.black87))))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildImageButton(String label, IconData icon,
      {bool isPrimary = false}) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.5)),
        color: isPrimary
            ? Colors.blue.withValues(alpha: 0.05)
            : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.cyan, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionTypes() {
    return SizedBox(
      height: 180.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _sessionTypes.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final type = _sessionTypes[index];
          final isSelected = _selectedSessionIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedSessionIndex = index),
            child: Container(
              width: 160.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 2.w,
                ),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          type['color'].withValues(alpha: 0.7),
                          type['color']
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(type['icon'], color: Colors.white, size: 35.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    type['label'],
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    type['subtitle'],
                    style: TextStyle(color: Colors.black45, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF007BFF), Color(0xFF00D1FF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF007BFF).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          final question = _questionController.text;
          if (_selectedSessionIndex == 0) {
            if (question.isNotEmpty) {
              context.read<ChatProvider>().sendMessage(
                    question,
                    userName:
                        'Aryan', // Hardcoded for now, ideally from AuthProvider
                  );
            }
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const AiChatScreen(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          } else if (_selectedSessionIndex == 1) {
            if (question.isNotEmpty) {
              context.read<ChatProvider>().sendMessage(
                    question,
                    userName: 'Aryan',
                  );
            }
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const TeacherSearchingScreen(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('This session type is coming soon!')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Submit Your Doubt',
              style: AppTextStyles.buttonLarge
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.arrow_outward, color: Colors.white, size: 18.sp),
          ],
        ),
      ),
    );
  }
}
