import 'package:flutter/material.dart';
import 'dart:math' as math;

class SpinWinScreen extends StatefulWidget {
  const SpinWinScreen({super.key});

  @override
  State<SpinWinScreen> createState() => _SpinWinScreenState();
}

class _SpinWinScreenState extends State<SpinWinScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spin() {
    if (_controller.isAnimating) return;
    _controller.reset();
    final double randomSpin =
        math.Random().nextDouble() * 10 + 5; // 5 to 15 full spins
    final double targetValue = randomSpin * 2 * math.pi;
    _animation = Tween<double>(begin: 0, end: targetValue).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF030712);
    const Color accentBlue = Color(0xFF3B82F6);

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Spin & Win',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 60),
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value,
                      child: CustomPaint(
                        size: const Size(300, 300),
                        painter: WheelPainter(),
                      ),
                    );
                  },
                ),
                // Legend
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value,
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Stack(
                          children: List.generate(8, (index) {
                            return Transform.rotate(
                              angle: index * (math.pi / 4) + (math.pi / 8),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 35),
                                  child: Transform.rotate(
                                    angle: -(index * (math.pi / 4) +
                                        (math.pi / 8)),
                                    child: Text(
                                      '${(index + 1) * 10}\nCoins',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        shadows: [
                                          Shadow(
                                              blurRadius: 4,
                                              color: Colors.black45)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
                // Pointer
                Positioned(
                  top: -15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: accentBlue.withOpacity(0.5), blurRadius: 10)
                      ],
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.arrow_drop_down,
                        color: accentBlue, size: 40),
                  ),
                ),
                // Center Button
                Container(
                  width: 50,
                  height: 50,
                  child: const Center(
                    child: Icon(Icons.play_arrow, color: accentBlue, size: 30),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            GestureDetector(
              onTap: _spin,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                decoration: BoxDecoration(
                  color: accentBlue,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: accentBlue.withOpacity(0.5),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Text(
                  'Spin Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final List<Color> colors = [
      const Color(0xFF6366F1), // Indigo
      const Color(0xFF8B5CF6), // Violet
      const Color(0xFFEC4899), // Pink
      const Color(0xFFF43F5E), // Rose
      const Color(0xFFF59E0B), // Amber
      const Color(0xFF10B981), // Emerald
      const Color(0xFF06B6D4), // Cyan
      const Color(0xFF3B82F6), // Blue
    ];

    final paint = Paint()..style = PaintingStyle.fill;
    final dividerPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 8; i++) {
      paint.color = colors[i];
      canvas.drawArc(rect, i * math.pi / 4, math.pi / 4, true, paint);
      // Draw border lines
      final double angle = i * math.pi / 4;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), dividerPaint);
    }

    // Outer ring
    final ringPaint = Paint()
      ..color = const Color(0xFFFBBF24) // Yellow 400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, radius, ringPaint);

    // Outer glow effect (subtle)
    final glowPaint = Paint()
      ..color = const Color(0xFFFBBF24).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, glowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
