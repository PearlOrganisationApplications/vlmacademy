import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../shared/background_screen.dart';
import 'dart:ui';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      useSafeArea: false,
      body: SafeArea(
        child: Column(
          children: [
            _buildTeacherHeader(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  SizedBox(height: 20.h),
                  _buildMessageBubble(
                    'Hi Prof. Priya, can you help me with this problem? (Attached image of problem 3b)',
                    '9:45 AM',
                    isSender: true,
                    showAttachment: true,
                  ),
                  _buildMessageBubble(
                    'Hello Aryan! Absolutely. Problem 3b asks to find critical points.\n\nStep 1: Find f\'(x).\nStep 2: Set f\'(x) = 0 and solve for x.\nLet\'s do it together...',
                    '9:45 AM',
                    isSender: false,
                  ),
                  _buildMessageBubble(
                    'Can waring you off this problem?',
                    '9:43 AM',
                    isSender: true,
                    userName: 'Aryan',
                  ),
                  _buildMessageBubble(
                    'Well, can you use explanation points alone?\nStep 1: Find f\'(x).\nStep 2: Set f\'(x) = 0 and solve for points...',
                    '9:43 AM',
                    isSender: false,
                  ),
                ],
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherHeader() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: EdgeInsets.all(20.w),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundImage:
                        const NetworkImage('https://i.pravatar.cc/150?u=priya'),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Priya S.',
                          style: AppTextStyles.h6.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            'PREMIUM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('4.9 Stars',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 12.sp)),
                        SizedBox(width: 4.w),
                        ...List.generate(
                            5,
                            (index) => Icon(Icons.star,
                                color: Colors.orangeAccent, size: 14.sp)),
                      ],
                    ),
                    Text(
                      'Advanced Mathematics - Calculus',
                      style: TextStyle(color: Colors.white60, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String text, String time,
      {required bool isSender, bool showAttachment = false, String? userName}) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isSender || userName != null)
            Padding(
              padding: EdgeInsets.only(
                  bottom: 4.h,
                  right: isSender ? 4.w : 0,
                  left: isSender ? 0 : 60.w),
              child: Text(
                isSender ? userName! : 'Priya S.',
                style: TextStyle(color: Colors.white60, fontSize: 12.sp),
              ),
            ),
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isSender) ...[
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage:
                      const NetworkImage('https://i.pravatar.cc/150?u=priya'),
                ),
                SizedBox(width: 10.w),
              ],
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    gradient: isSender
                        ? const LinearGradient(
                            colors: [Color(0xFF2F80FF), Color(0xFF1B4EAA)])
                        : null,
                    color: isSender
                        ? null
                        : const Color(0xFF8B5CF6).withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(isSender ? 20.r : 0),
                      bottomRight: Radius.circular(isSender ? 0 : 20.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        text,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                                color: Colors.white60, fontSize: 10.sp),
                          ),
                          if (showAttachment) ...[
                            SizedBox(width: 4.w),
                            Icon(Icons.attach_file,
                                color: Colors.white60, size: 12.sp),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: 'Type your question here...',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.red, size: 24.sp),
                  ),
                  SizedBox(height: 4.h),
                  Text('END\nSESSION',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Icon(Icons.attach_file, color: Colors.grey, size: 24.sp),
              SizedBox(width: 8.w),
              Text('Attach Image',
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF4285F4), Color(0xFF34A853)]),
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5)),
                  ],
                ),
                child: Row(
                  children: [
                    Text('Send',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp)),
                    SizedBox(width: 8.w),
                    Icon(Icons.send, color: Colors.white, size: 20.sp),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
