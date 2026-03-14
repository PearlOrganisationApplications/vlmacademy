import 'package:flutter/material.dart';
import '../data/models/chat_message.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  int _aiCredits = 1250;
  final int _maxCredits = 2000;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  int get aiCredits => _aiCredits;
  int get maxCredits => _maxCredits;

  void sendMessage(String text, {String? userName}) {
    if (text.trim().isEmpty) return;

    // Add user message
    _messages.add(ChatMessage(
      text: text,
      role: MessageRole.user,
      userName: userName,
    ));
    notifyListeners();

    // Simulate AI response
    _simulateAiResponse(text);
  }

  void _simulateAiResponse(String userText) {
    // Deduct credits
    if (_aiCredits >= 10) {
      _aiCredits -= 10;
    }

    String response = "I'm processing your request about '$userText'. How else can I help you today?";
    
    // Custom responses based on keywords (for demo/active learning feel)
    if (userText.contains('3x²')) {
      response = "Certainly! Let's solve this quadratic equation.\n\nFirst, we find the discriminant, D = b² - 4ac.\nFor this equation, a=3, b=-5, c=2.\nD = (-5)² - 4(3)(2) = 25 - 24 = 1.\nSince D > 0, there are two real roots.\n\nNow we use the quadratic formula:\nx = [-b ± √D] / 2a.\nx = [-(-5) ± √1] / 2(3).\nx = [5 ± 1] / 6.\n\nThis gives two roots: x1 = (5+1)/6 = 1 and x2 = (5-1)/6 = 4/6 = 2/3.\n\nSo, the roots are x=1 and x=2/3.";
    }

    Future.delayed(const Duration(seconds: 1), () {
      _messages.add(ChatMessage(
        text: response,
        role: MessageRole.ai,
      ));
      notifyListeners();
    });
  }

  void addAiCommandResponse(String command) {
    String response = "";
    switch (command.toLowerCase()) {
      case 'simplify':
        response = "I have simplified the previous explanation for you. Is it clearer now?";
        break;
      case 'example':
        response = "Here is another example: solve 2x² - 4x + 2 = 0. The discriminant D = 0, so there is one real root x = 1.";
        break;
      case 'hindi':
        response = "ठीक है, मैं इसे हिंदी में समझाता हूँ। यह एक द्विघात समीकरण है...";
        break;
      case 'practice':
        response = "Sure! Here's a practice question for you:\n\nSolve for x: x² - 4x + 4 = 0.\n\nType your answer below and I'll check it!";
        break;
      case 'connect':
        response = "I'm connecting you to a live math expert now. Please wait a moment while we find an available teacher.";
        break;
      default:
        response = "Executing command: $command";
    }

    _messages.add(ChatMessage(
      text: response,
      role: MessageRole.ai,
    ));
    notifyListeners();
  }
}
