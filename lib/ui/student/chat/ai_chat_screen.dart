import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../shared/background_screen.dart';
import 'dart:ui';
import 'session_feedback_screen.dart';
import 'package:provider/provider.dart';
import '../../../../providers/chat_provider.dart';
import '../../../../data/models/chat_message.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      useSafeArea: false,
      body: SafeArea(
        child: Consumer<ChatProvider>(
          builder: (context, chatProvider, child) {
            _scrollToBottom();
            return Column(
              children: [
                _buildHeader(context, chatProvider),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Center(
                        child: Text(
                          'AI Tutor - Active Learning',
                          style: AppTextStyles.h4.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Expanded(
                        child: ListView.separated(
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: chatProvider.messages.length,
                          separatorBuilder: (_, __) => SizedBox(height: 20.h),
                          itemBuilder: (context, index) {
                            final message = chatProvider.messages[index];
                            if (message.role == MessageRole.user) {
                              return _buildUserMessage(
                                message.userName ?? 'User',
                                message.text,
                              );
                            } else {
                              return _buildAiMessage(message.text);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                _buildActionButtons(chatProvider),
                _buildMessageInput(chatProvider),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ChatProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SessionFeedbackScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'END SESSION',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Image.asset(AppImages.vlmLogo, height: 40.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Text(
                  'AI Credits:',
                  style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                ),
                Text(
                  '${provider.aiCredits} / ${provider.maxCredits}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMessage(String name, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 60.w, bottom: 4.h),
          child: Text(
            name,
            style: TextStyle(color: Colors.white70, fontSize: 13.sp),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.black87, fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.blue[100],
              child: Icon(Icons.person, color: Colors.blue[800]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAiMessage(String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 60.w, bottom: 4.h),
          child: Text(
            'VLM AI Tutor',
            style:
                AppTextStyles.h6.copyWith(color: Colors.white, fontSize: 14.sp),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45.w,
              height: 45.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.purpleAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purpleAccent.withValues(alpha: 0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.smart_toy, color: Colors.white, size: 24),
              ),
            ),
            SizedBox(width: 12.w),
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      message,
                      style: TextStyle(color: Colors.black87, fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(ChatProvider provider) {
    final actions = [
      {'label': 'Simplify', 'icon': Icons.auto_fix_high, 'cmd': 'simplify'},
      {'label': 'Example', 'icon': Icons.lightbulb_outline, 'cmd': 'example'},
      {'label': 'Explain in Hindi', 'icon': Icons.translate, 'cmd': 'hindi'},
      {
        'label': 'Practice Question',
        'icon': Icons.quiz_outlined,
        'cmd': 'practice'
      },
      {
        'label': 'Connect Live Teacher',
        'icon': Icons.sensors,
        'cmd': 'connect'
      },
    ];

    return Container(
      height: 110.h,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final action = actions[index];
          return GestureDetector(
            onTap: () => provider.addAiCommandResponse(action['cmd'] as String),
            child: Container(
              width: 85.w,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(action['icon'] as IconData,
                      color: Colors.white, size: 28.sp),
                  SizedBox(height: 8.h),
                  Text(
                    action['label'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageInput(ChatProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.image_outlined,
                      color: Colors.blue[800], size: 24.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        hintText: 'Ask another question...',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 14.sp),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      onSubmitted: (val) {
                        provider.sendMessage(val, userName: 'Aryan');
                        _messageController.clear();
                      },
                    ),
                  ),
                  Icon(Icons.mic_none, color: Colors.blue[800], size: 24.sp),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () {
              provider.sendMessage(_messageController.text, userName: 'Aryan');
              _messageController.clear();
            },
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2F80FF), Color(0xFF1B4EAA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(Icons.send, color: Colors.white, size: 24.sp),
            ),
          ),
        ],
      ),
    );
  }
}
