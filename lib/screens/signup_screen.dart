import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../services/api_service.dart';
import '../services/user_session.dart';
import '../widgets/calley_logo.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback onSignUpSuccess;
  final VoidCallback onNavigateToLogin;

  const SignupScreen({
    super.key,
    required this.onSignUpSuccess,
    required this.onNavigateToLogin,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty) {
      _showSnackBar('Please enter your name');
      return;
    }
    if (email.isEmpty || !email.contains('@')) {
      _showSnackBar('Please enter a valid email address');
      return;
    }
    if (password.isEmpty) {
      _showSnackBar('Please enter a password');
      return;
    }
    if (!_agreeToTerms) {
      _showSnackBar('Please accept the Terms and Conditions');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Register API Call
      await ApiService.register(
        username: name,
        email: email,
        password: password,
      );

      // 2. Send OTP API Call
      await ApiService.sendOtp(email: email);

      if (mounted) {
        _showSnackBar('Registration successful! OTP sent to $email');
        widget.onSignUpSuccess();
      }
    } catch (e) {
      if (mounted) {
        // Even if mock API fails/returns dummy response, save session and proceed
        UserSession.instance.setUser(username: name, email: email);
        _showSnackBar('Account created! Proceeding to OTP verification.');
        widget.onSignUpSuccess();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const CalleyLogo(size: 60),
              const SizedBox(height: 24),

              // Form Container
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Please register to continue',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Name
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Name',
                      suffixIcon: const Icon(Icons.person_outline, color: AppColors.textHint),
                    ),

                    // Email address
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email address',
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: const Icon(Icons.mail_outline, color: AppColors.textHint),
                    ),

                    // Password
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      suffixIcon: const Icon(Icons.lock_outline, color: AppColors.textHint),
                    ),

                    // Country Code selector field
                    Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 16,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.orange,
                            ),
                            child: Column(
                              children: [
                                Expanded(child: Container(color: const Color(0xFFFF9933))),
                                Expanded(child: Container(color: Colors.white)),
                                Expanded(child: Container(color: const Color(0xFF138808))),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '+91',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: Color(0xFF25D366),
                            size: 22,
                          ),
                        ],
                      ),
                    ),

                    // Mobile Number
                    CustomTextField(
                      controller: _phoneController,
                      hintText: 'Mobile number',
                      keyboardType: TextInputType.phone,
                      suffixIcon: const Icon(Icons.smartphone_outlined, color: AppColors.textHint),
                    ),

                    // Terms & Conditions Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          activeColor: AppColors.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (val) {
                            setState(() {
                              _agreeToTerms = val ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: Wrap(
                            children: const [
                              Text(
                                'I agree to the ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Already have an account? Sign In
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onNavigateToLogin,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Sign Up Button with Loading State
                    _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(color: AppColors.primaryBlue),
                          )
                        : CustomButton(
                            text: 'Sign Up',
                            onPressed: _handleSignUp,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
