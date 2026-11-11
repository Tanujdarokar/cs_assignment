import 'package:flutter/material.dart';
import '../core/constants/app_assets.dart';

class WhatsappButton extends StatelessWidget {
  final VoidCallback? onTap;

  const WhatsappButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF25D366), width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            AppAssets.whatsappLogo,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.chat_bubble_rounded,
                color: Color(0xFF25D366),
                size: 26,
              );
            },
          ),
        ),
      ),
    );
  }
}
