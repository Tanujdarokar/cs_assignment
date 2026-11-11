import 'dart:math';
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class DonutChartWidget extends StatelessWidget {
  final double pendingCalls;
  final double doneCalls;
  final double scheduledCalls;

  const DonutChartWidget({
    super.key,
    this.pendingCalls = 28,
    this.doneCalls = 22,
    this.scheduledCalls = 9,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: CustomPaint(
        painter: _DonutChartPainter(
          pending: pendingCalls,
          done: doneCalls,
          scheduled: scheduledCalls,
        ),
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final double pending;
  final double done;
  final double scheduled;

  _DonutChartPainter({
    required this.pending,
    required this.done,
    required this.scheduled,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final strokeWidth = size.width * 0.22;
    final drawRadius = outerRadius - strokeWidth / 2;

    final total = pending + done + scheduled;
    if (total == 0) return;

    final sweepPending = (pending / total) * 2 * pi;
    final sweepDone = (done / total) * 2 * pi;
    final sweepScheduled = (scheduled / total) * 2 * pi;

    const gap = 0.08; // gap between segments

    // Paint Blue/Done segment
    final donePaint = Paint()
      ..color = AppColors.chartBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Paint Purple segment
    final purplePaint = Paint()
      ..color = AppColors.chartPurple
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Paint Orange segment
    final orangePaint = Paint()
      ..color = AppColors.chartOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    var startAngle = -pi / 2;

    // Segment 1: Blue
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: drawRadius),
      startAngle,
      sweepDone - gap,
      false,
      donePaint,
    );
    startAngle += sweepDone;

    // Segment 2: Purple
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: drawRadius),
      startAngle,
      sweepScheduled - gap,
      false,
      purplePaint,
    );
    startAngle += sweepScheduled;

    // Segment 3: Orange
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: drawRadius),
      startAngle,
      sweepPending - gap,
      false,
      orangePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
