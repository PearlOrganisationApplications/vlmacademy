import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage:
                  NetworkImage('https://i.pravatar.cc/150?u=natasha'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Natasha',
                  style: AppTextStyles.h6.copyWith(color: Colors.white),
                ),
                Text(
                  'Online',
                  style: AppTextStyles.caption
                      .copyWith(color: Colors.green, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.videocam_outlined, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.call_outlined, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Today',
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMessageBubble(
                  'Hi, Nicholas Good Evening 😊',
                  '20:45',
                  isSender: false,
                ),
                _buildMessageBubble(
                  'How was your UI/UX Design Course Like..?',
                  '22:45',
                  isSender: false,
                ),
                _buildMessageBubble(
                  'Hi, Morning too Ronald',
                  '15:29',
                  isSender: true,
                ),
                _buildImageMessage(isSender: true),
                _buildMessageBubble(
                  'Hello, I also just finished the Sketch Basic ⭐⭐⭐⭐',
                  '15:29',
                  isSender: true,
                ),
                _buildMessageBubble(
                  'OMG, This is Amazing..',
                  '23:59',
                  isSender: false,
                ),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, String time,
      {required bool isSender}) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          gradient: isSender ? AppColors.primaryGradient : null,
          color: isSender ? null : const Color(0xFF1E293B),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isSender ? 15 : 0),
            bottomRight: Radius.circular(isSender ? 0 : 15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageMessage({required bool isSender}) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                  'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=100',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover),
            ),
            const SizedBox(width: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                  'https://images.unsplash.com/photo-1542831371-29b0f74f9713?w=100',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Message',
                  hintStyle: TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF1E293B),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mic, color: Colors.blue),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
