import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_button.dart';

class LanguageSelectionScreen extends StatefulWidget {
  final VoidCallback onSelectLanguage;

  const LanguageSelectionScreen({
    super.key,
    required this.onSelectLanguage,
  });

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _languages = [
    {'name': 'English', 'sub': 'Hi'},
    {'name': 'Hindi', 'sub': 'नमस्ते'},
    {'name': 'Bengali', 'sub': 'হ্যালো'},
    {'name': 'Kannada', 'sub': 'ನಮಸ್ಕಾರ'},
    {'name': 'Punjabi', 'sub': 'ਸਤਿ ਸ਼੍ਰੀ ਅਕਾਲ'},
    {'name': 'Tamil', 'sub': 'வணக்கம்'},
    {'name': 'Telugu', 'sub': 'హలో'},
    {'name': 'French', 'sub': 'Bonjour'},
    {'name': 'Spanish', 'sub': 'Hola'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                'Choose Your Language',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // Language List Card
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _languages.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      color: AppColors.border,
                      indent: 16,
                      endIndent: 16,
                    ),
                    itemBuilder: (context, index) {
                      final item = _languages[index];
                      final isSelected = _selectedIndex == index;

                      return Material(
                        color: Colors.transparent,
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          title: Text(
                            item['name']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          subtitle: Text(
                            item['sub']!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          trailing: Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: isSelected
                                ? AppColors.primaryBlue
                                : AppColors.textHint,
                            size: 24,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Bottom Select Button
              CustomButton(
                text: 'Select',
                onPressed: widget.onSelectLanguage,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
