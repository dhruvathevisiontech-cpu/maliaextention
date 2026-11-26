import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Hair-extension weft loader: a clip-in weft with long silky strands that
/// sway softly while a shine sweeps across. Drawn in code (no assets/packages).
class HairWeftLoader extends StatefulWidget {
  final double width;
  final double height;
  final Color hairColor; // base strand color
  final Color shineColor; // moving highlight
  final Color weftColor; // the top strip + clips

  const HairWeftLoader({
    super.key,
    this.width = 150,
    this.height = 110,
    this.hairColor = const Color(0xFF2B1B17), // deep brown
    this.shineColor = const Color(0xFFE8CFA0), // warm gold highlight
    this.weftColor = const Color(0xFF1A1A1A),
  });

  @override
  State<HairWeftLoader> createState() => _HairWeftLoaderState();
}

class _HairWeftLoaderState extends State<HairWeftLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _WeftPainter(
            _controller.value,
            widget.hairColor,
            widget.shineColor,
            widget.weftColor,
          ),
        ),
      ),
    );
  }
}

class _WeftPainter extends CustomPainter {
  final double t;
  final Color hair;
  final Color shine;
  final Color weft;

  _WeftPainter(this.t, this.hair, this.shine, this.weft);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    const strands = 26;
    final barH = h * 0.08;
    final padX = w * 0.08;
    final usable = w - padX * 2;
    final y0 = barH * 0.8;

    // Moving shine band: a gradient rect that slides left -> right.
    final bandW = w * 0.55;
    final dx = -bandW + (w + bandW) * t;
    final shader = LinearGradient(
      colors: [hair, shine, hair],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(Rect.fromLTWH(dx, 0, bandW, h));

    final strandPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = math.max(1.6, w * 0.014)
      ..shader = shader;

    for (int i = 0; i < strands; i++) {
      final f = i / (strands - 1);
      final x = padX + usable * f;
      final len = (h - y0) * (0.90 + 0.08 * math.sin(i * 1.7));
      final sway = math.sin(t * 2 * math.pi + i * 0.28) * w * 0.035;

      final path = Path()
        ..moveTo(x, y0)
        ..cubicTo(
          x + sway * 0.3, y0 + len * 0.33,
          x + sway * 1.3, y0 + len * 0.66,
          x + sway * 0.9, y0 + len,
        );
      canvas.drawPath(path, strandPaint);
    }

    // Weft strip on top.
    final barRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(padX - 4, 0, usable + 8, barH),
      Radius.circular(barH / 2),
    );
    canvas.drawRRect(barRect, Paint()..color = weft);

    // Three small clips on the weft.
    final clipPaint = Paint()..color = weft.withOpacity(0.9);
    final clipEdge = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = shine.withOpacity(0.7);
    for (final cf in [0.18, 0.5, 0.82]) {
      final cx = padX + usable * cf;
      final clip = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, barH * 0.5), width: w * 0.09, height: barH * 1.5),
        Radius.circular(3),
      );
      canvas.drawRRect(clip, clipPaint);
      canvas.drawRRect(clip, clipEdge);
    }
  }

  @override
  bool shouldRepaint(covariant _WeftPainter old) => old.t != t;
}