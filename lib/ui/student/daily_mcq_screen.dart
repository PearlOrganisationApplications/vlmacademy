import 'package:flutter/material.dart';
import 'dart:async';

class DailyMcqScreen extends StatefulWidget {
  const DailyMcqScreen({super.key});

  @override
  State<DailyMcqScreen> createState() => _DailyMcqScreenState();
}

class _DailyMcqScreenState extends State<DailyMcqScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'topic': 'Geography',
      'question': 'What is the capital of India?',
      'options': {
        'A': 'Dehradun',
        'B': 'Mumbai',
        'C': 'Delhi',
        'D': 'Hyderabad'
      },
      'correct': 'C'
    },
    {
      'topic': 'Science',
      'question': 'What is the chemical symbol for Water?',
      'options': {'A': 'CO2', 'B': 'H2O', 'C': 'NaCl', 'D': 'O2'},
      'correct': 'B'
    },
    {
      'topic': 'History',
      'question': 'Who was the first Prime Minister of India?',
      'options': {
        'A': 'B.R. Ambedkar',
        'B': 'Mahatma Gandhi',
        'C': 'J. Nehru',
        'D': 'S. Patel'
      },
      'correct': 'C'
    },
    {
      'topic': 'Math',
      'question': 'What is the square root of 144?',
      'options': {'A': '10', 'B': '12', 'C': '14', 'D': '16'},
      'correct': 'B'
    },
    {
      'topic': 'Biology',
      'question': 'Which organ pumps blood in the human body?',
      'options': {'A': 'Lungs', 'B': 'Brain', 'C': 'Heart', 'D': 'Liver'},
      'correct': 'C'
    },
  ];

  int _currentIndex = 0;
  int _score = 0;
  bool _isFinished = false;
  int _secondsLeft = 25;
  Timer? _timer;
  String? _selectedOption;
  bool _isAnswered = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = 25;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        _timer?.cancel();
        _nextQuestion();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handleOptionSelect(String option) {
    if (_isAnswered || _isFinished) return;
    _timer?.cancel();

    setState(() {
      _selectedOption = option;
      _isAnswered = true;
      if (option == _questions[_currentIndex]['correct']) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _nextQuestion();
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _isAnswered = false;
        _startTimer();
      });
    } else {
      setState(() => _isFinished = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF030712);
    const Color accentBlue = Color(0xFF3B82F6);
    const Color surfaceColor = Color(0xFF0F172A);

    if (_isFinished) return _buildResults(context, bgColor, accentBlue);

    final currentQuestion = _questions[_currentIndex];
    final options = currentQuestion['options'] as Map<String, String>;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('MCQ Challenge',
            style: TextStyle(color: Colors.white70, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            // Top Status Bar - Pillar Styles
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusPill(
                  Icons.local_fire_department,
                  '6 Day Streak',
                  const Color(0xFF3B82F6).withOpacity(0.8),
                  Colors.orange,
                ),
                _buildStatusPill(
                  Icons.stars,
                  '1,250 Coins',
                  const Color(0xFF06B6D4).withOpacity(0.8),
                  Colors.amber,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Main Unified Challenge Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    accentBlue.withOpacity(0.9),
                    const Color(0xFF0F172A),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white10.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Daily MCQ Challenge',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentQuestion['topic'],
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 30),
                        // Timer Circle
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(
                                value: _secondsLeft / 25,
                                strokeWidth: 8,
                                backgroundColor: Colors.white24,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            ),
                            Text(
                              '00:${_secondsLeft.toString().padLeft(2, '0')}s',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Question section
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          currentQuestion['question'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 30),

                        // Options Grid
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 2.2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children: options.entries.map((entry) {
                            return _buildOption(entry.key, entry.value);
                          }).toList(),
                        ),
                        const SizedBox(height: 40),

                        // Progress Section
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: (_currentIndex + 1) / _questions.length,
                                minHeight: 8,
                                backgroundColor: surfaceColor,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(accentBlue),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Question ${_currentIndex + 1}/${_questions.length}',
                              style: const TextStyle(
                                  color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(
      BuildContext context, Color bgColor, Color primaryColor) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.stars_rounded, color: Colors.amber, size: 100),
              const SizedBox(height: 20),
              const Text(
                'Challenge Completed!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'You scored $_score out of ${_questions.length}',
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Back to Home',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusPill(
      IconData icon, String text, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String code, String text) {
    bool isSelected = _selectedOption == code;
    bool isCorrect = code == _questions[_currentIndex]['correct'];

    Color borderColor = Colors.white10;
    Widget? icon;

    if (_isAnswered) {
      if (isCorrect) {
        borderColor = Colors.greenAccent.withOpacity(0.5);
        icon =
            const Icon(Icons.check_circle, color: Colors.greenAccent, size: 16);
      } else if (isSelected) {
        borderColor = Colors.redAccent.withOpacity(0.5);
        icon = const Icon(Icons.cancel, color: Colors.redAccent, size: 16);
      }
    } else if (isSelected) {
      borderColor = Colors.blueAccent;
    }

    return GestureDetector(
      onTap: () => _handleOptionSelect(code),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(isSelected ? 0.15 : 0.08),
              Colors.white.withOpacity(isSelected ? 0.05 : 0.02),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Text(
              '$code. $text',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            if (icon != null) icon,
          ],
        ),
      ),
    );
  }
}
