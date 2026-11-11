import 'package:flutter/material.dart';
import '../core/constants/app_assets.dart';
import '../core/theme/app_colors.dart';

class CalleyLogo extends StatelessWidget {
  final double size;
  final bool showText;

  const CalleyLogo({
    super.key,
    this.size = 60.0,
    this.showText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logoCompany,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: _LogoSwirlPainter(),
              ),
            ),
            if (showText) ...[
              const SizedBox(height: 8),
              const Text(
                'CALLEY',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: Color(0xFF0284C7),
                ),
              ),
              const Text(
                'AUTOMATIC CALL DIALER',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _LogoSwirlPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..shader = const SweepGradient(
        colors: [
          Color(0xFF22C55E),
          Color(0xFF06B6D4),
          Color(0xFF3B82F6),
          Color(0xFFEC4899),
          Color(0xFFEAB308),
        ],
        stops: [0.0, 0.25, 0.5, 0.75, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.28
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: radius * 0.65),
        -0.8,
        4.8,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
