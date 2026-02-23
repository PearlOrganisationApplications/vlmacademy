import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'chat_detail_screen.dart';
import 'ai_chat_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  bool _isAiChat = false;

  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'Natasha',
      'message': 'Hi, Good Evening Bro!',
      'time': '16:00',
      'unread': 8,
      'avatar': 'https://i.pravatar.cc/150?u=natasha',
    },
    {
      'name': 'Alex',
      'message': 'I Just Finished IT',
      'time': '08:35',
      'unread': 2,
      'avatar': 'https://i.pravatar.cc/150?u=alex',
    },
    {
      'name': 'John',
      'message': 'How are you?',
      'time': '08:30',
      'unread': 0,
      'avatar': 'https://i.pravatar.cc/150?u=john',
    },
    {
      'name': 'Mia',
      'message': 'OMG, This is Amazing..',
      'time': '21:57',
      'unread': 5,
      'avatar': 'https://i.pravatar.cc/150?u=mia',
    },
    {
      'name': 'Meria',
      'message': 'Wow, This is Really Epic',
      'time': '08:35',
      'unread': 2,
      'avatar': 'https://i.pravatar.cc/150?u=meria',
    },
    {
      'name': 'Tiya',
      'message': 'Hi, Good Evening Bro!',
      'time': '16:00',
      'unread': 8,
      'avatar': 'https://i.pravatar.cc/150?u=tiya',
    },
    {
      'name': 'Manisha',
      'message': 'I Just Finished IT',
      'time': '08:35',
      'unread': 2,
      'avatar': 'https://i.pravatar.cc/150?u=manisha',
    },
  ];

  final List<Map<String, dynamic>> _aiChats = [
    {
      'name': 'AI Tutor',
      'message': 'Hello Markha how can I help you 🤖',
      'time': 'Today',
      'unread': 1,
      'avatar': 'https://i.pravatar.cc/150?u=ai_tutor',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Inbox',
                    style: AppTextStyles.h4.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon:
                        const Icon(Icons.search, color: Colors.white, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isAiChat = false),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient:
                                !_isAiChat ? AppColors.primaryGradient : null,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Chat',
                            style: TextStyle(
                              color: !_isAiChat ? Colors.white : Colors.white54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isAiChat = true),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient:
                                _isAiChat ? AppColors.primaryGradient : null,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'AI Chat',
                            style: TextStyle(
                              color: _isAiChat ? Colors.white : Colors.white54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Chat List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _isAiChat ? _aiChats.length : _chats.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white.withOpacity(0.05),
                  height: 1,
                  indent: 70,
                ),
                itemBuilder: (context, index) {
                  final chat = _isAiChat ? _aiChats[index] : _chats[index];
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(chat['avatar']),
                        ),
                        if (!_isAiChat) // Status indicator
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.backgroundDark, width: 2),
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      chat['name'],
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      chat['message'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (chat['unread'] > 0)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${chat['unread']}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          chat['time'],
                          style: const TextStyle(
                              color: Colors.white30, fontSize: 11),
                        ),
                      ],
                    ),
                    onTap: () {
                      if (_isAiChat) {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => const AiChatScreen()),
                        );
                      } else {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => const ChatDetailScreen()),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
