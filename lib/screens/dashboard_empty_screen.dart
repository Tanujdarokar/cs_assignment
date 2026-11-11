import 'package:flutter/material.dart';
import '../core/constants/app_assets.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/custom_button.dart';
import '../widgets/whatsapp_button.dart';

class DashboardEmptyScreen extends StatefulWidget {
  final VoidCallback onOpenDrawer;
  final VoidCallback onStartCalling;
  final VoidCallback onOpenSettings;

  const DashboardEmptyScreen({
    super.key,
    required this.onOpenDrawer,
    required this.onStartCalling,
    required this.onOpenSettings,
  });

  @override
  State<DashboardEmptyScreen> createState() => _DashboardEmptyScreenState();
}

class _DashboardEmptyScreenState extends State<DashboardEmptyScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary, size: 28),
          onPressed: widget.onOpenDrawer,
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.headset_mic_outlined, color: AppColors.textPrimary, size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary, size: 24),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            // User Greeting Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFFFACC15),
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hello Swati',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Welcome to Calley!',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Main Illustration Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: [
                        // Dark Card Header
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: double.infinity,
                          color: const Color(0xFF1E2B4D),
                          child: const Text(
                            'LOAD NUMBER TO CALL',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Body Content with Text & Graphic Illustration
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Visit https://app.getcalley.com to upload numbers that you wish to call using Calley Mobile App.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textPrimary,
                                    height: 1.4,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                // Graphic Illustration of Agent
                                Expanded(
                                  flex: 8,
                                  child: Image.asset(
                                    AppAssets.dashboardImg,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return SizedBox(
                                        height: 200,
                                        child: CustomPaint(
                                          size: const Size(220, 200),
                                          painter: _AgentIllustrationPainter(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Bottom Action Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const WhatsappButton(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Star Calling Now',
                      onPressed: widget.onStartCalling,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _navIndex,
        onItemTapped: (index) {
          setState(() {
            _navIndex = index;
          });
          if (index == 1) {
            widget.onOpenSettings();
          }
        },
      ),
    );
  }
}

class _AgentIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Blue Phone Frame
    final phonePaint = Paint()
      ..color = const Color(0xFF1E2B4D)
      ..style = PaintingStyle.fill;
    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.15, size.height * 0.1, size.width * 0.7, size.height * 0.85),
      const Radius.circular(16),
    );
    canvas.drawRRect(phoneRect, phonePaint);

    // Screen
    final screenPaint = Paint()..color = const Color(0xFF60A5FA);
    final screenRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.18, size.height * 0.14, size.width * 0.64, size.height * 0.77),
      const Radius.circular(12),
    );
    canvas.drawRRect(screenRect, screenPaint);

    // Character Body (Red shirt)
    final charPaint = Paint()..color = const Color(0xFFEF4444);
    final charPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.9)
      ..lineTo(size.width * 0.4, size.height * 0.5)
      ..lineTo(size.width * 0.6, size.height * 0.5)
      ..lineTo(size.width * 0.7, size.height * 0.9)
      ..close();
    canvas.drawPath(charPath, charPaint);

    // Character Head
    final headPaint = Paint()..color = const Color(0xFFFFD19A);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 22, headPaint);

    // Headset
    final headsetPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width * 0.5, size.height * 0.38), radius: 24),
      -3.14,
      3.14,
      false,
      headsetPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
