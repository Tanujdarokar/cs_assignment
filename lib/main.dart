import 'package:flutter/material.dart';
import 'core/theme/app_colors.dart';
import 'screens/language_selection_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/otp_verification_screen.dart';
import 'screens/login_screen.dart';
import 'screens/welcome_banner_screen.dart';
import 'screens/dashboard_empty_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/dashboard_stats_screen.dart';
import 'widgets/custom_drawer.dart';

void main() {
  runApp(const CalleyApp());
}

class CalleyApp extends StatelessWidget {
  const CalleyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALLEY Automatic Call Dialer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBlue,
          primary: AppColors.primaryBlue,
        ),
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationController(),
    );
  }
}

class MainNavigationController extends StatefulWidget {
  const MainNavigationController({super.key});

  @override
  State<MainNavigationController> createState() => _MainNavigationControllerState();
}

enum AppScreen {
  languageSelection, // 01
  signup,            // 02
  otpVerification,   // 03
  login,             // 04
  welcomeBanner,     // 05
  dashboardEmpty,    // 06
  settings,          // 07
  dashboardStats,    // 08
}

class _MainNavigationControllerState extends State<MainNavigationController> {
  AppScreen _currentScreen = AppScreen.languageSelection;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigateTo(AppScreen screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        onNavigate: (route) {
          Navigator.pop(context); // Close drawer
          if (route == 'welcome') {
            _navigateTo(AppScreen.welcomeBanner);
          } else if (route == 'settings') {
            _navigateTo(AppScreen.settings);
          } else if (route == 'login') {
            _navigateTo(AppScreen.login);
          }
        },
      ),
      body: Stack(
        children: [
          // Current Active Screen View
          _buildScreenView(),
        ],
      ),
    );
  }

  Widget _buildScreenView() {
    switch (_currentScreen) {
      // Screen 01: Language Selection
      case AppScreen.languageSelection:
        return LanguageSelectionScreen(
          onSelectLanguage: () => _navigateTo(AppScreen.signup), // -> 02
        );

      // Screen 02: Register / Sign Up
      case AppScreen.signup:
        return SignupScreen(
          onSignUpSuccess: () => _navigateTo(AppScreen.otpVerification), // -> 03
          onNavigateToLogin: () => _navigateTo(AppScreen.login),         // -> 04
        );

      // Screen 03: Whatsapp OTP Verification
      case AppScreen.otpVerification:
        return OtpVerificationScreen(
          onVerifySuccess: () => _navigateTo(AppScreen.login), // -> 04
          onResendOtp: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP code resent successfully via WhatsApp')),
            );
          },
        );

      // Screen 04: Login / Sign In
      case AppScreen.login:
        return LoginScreen(
          onLoginSuccess: () => _navigateTo(AppScreen.welcomeBanner), // -> 05
          onNavigateToSignUp: () => _navigateTo(AppScreen.signup),     // -> 02
        );

      // Screen 05: Welcome Banner (2 Minute Challenge)
      case AppScreen.welcomeBanner:
        return WelcomeBannerScreen(
          onStartCalling: () => _navigateTo(AppScreen.dashboardEmpty), // -> 06
        );

      // Screen 06: Dashboard (Empty / Load Number)
      case AppScreen.dashboardEmpty:
        return DashboardEmptyScreen(
          onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(), // -> 09
          onStartCalling: () => _navigateTo(AppScreen.settings),      // -> 07
          onOpenSettings: () => _navigateTo(AppScreen.settings),      // -> 07
        );

      // Screen 07: Setting & Calling Lists Modal
      case AppScreen.settings:
        return SettingsScreen(
          onBack: () => _navigateTo(AppScreen.dashboardEmpty),          // -> 06
          onSelectTestList: () => _navigateTo(AppScreen.dashboardStats), // -> 08
        );

      // Screen 08: Dashboard (Stats & Chart)
      case AppScreen.dashboardStats:
        return DashboardStatsScreen(
          onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(), // -> 09
          onStartCalling: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Starting Calling Session for Test List...')),
            );
          },
        );
    }
  }
}
