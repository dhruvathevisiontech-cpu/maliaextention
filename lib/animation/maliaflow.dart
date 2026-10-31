import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:maliaextention/color/colorstheam.dart';

class MaliaFlowLoader extends StatefulWidget {
  final String message;
  final double size;

  const MaliaFlowLoader({
    super.key,
    this.message = 'Preparing something beautiful',
    this.size = 110,
  });

  @override
  State<MaliaFlowLoader> createState() => _MaliaFlowLoaderState();
}

class _MaliaFlowLoaderState extends State<MaliaFlowLoader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SizedBox(
                width: widget.size,
                height: widget.size * 0.8,
                child: CustomPaint(
                  painter: _SilkStrandPainter(
                    progress: _controller.value,
                    color: Colorstheam.Racingred,
                    secondaryColor: Colorstheam.arabiangrey,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 12),
          Text(
            'M A L I A',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colorstheam.nobelblack,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 12,
              color: Colorstheam.arabiangrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _SilkStrandPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color secondaryColor;

  _SilkStrandPainter({
    required this.progress,
    required this.color,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;
    final phase = progress * 2 * math.pi;
    for (int i = 0; i < 3; i++) {
      final offset = i * 0.65;
      final path = Path();
      path.moveTo(4, centerY);
      for (int step = 0; step <= 60; step++) {
        final t = step / 60;
        final x = 4 + t * (size.width - 8);
        final envelope = math.sin(t * math.pi);
        final wave = math.sin(t * 2 * math.pi + phase + offset,);
        final y = centerY + wave * envelope * (size.height * 0.32);
        path.lineTo(x, y);
      }

      final strandPaint = Paint()
        ..color = i == 1
            ? color
            : secondaryColor.withValues(alpha: 0.55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = i == 1 ? 2.2 : 1.2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      canvas.drawPath(path, strandPaint);
    }

    final t = progress;
    final x = 4 + t * (size.width - 8);
    final y = centerY +
        math.sin(t * 2 * math.pi + phase) *
            math.sin(t * math.pi) *
            (size.height * 0.32);

    canvas.drawCircle(
      Offset(x, y),
      3,
      Paint()..color = color.withValues(alpha: 0.22),
    );

    canvas.drawCircle(
      Offset(x, y),
      1.5,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant _SilkStrandPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.secondaryColor != secondaryColor;
  }
}