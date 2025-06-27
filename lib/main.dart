import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mama_ryadom/screens/accounts_screen.dart';
import 'package:mama_ryadom/screens/chat_list_screen.dart';
import 'package:mama_ryadom/screens/forgot_password.dart';
import 'package:mama_ryadom/screens/notifications_screen.dart';
import 'package:mama_ryadom/screens/settings_screen.dart';
import 'package:mama_ryadom/screens/sign_in_screen.dart';
import 'package:mama_ryadom/screens/sign_up_screen.dart';
import 'package:mama_ryadom/screens/welcome_screen.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the app to landscape orientation only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MamaRyadomApp());
}

class MamaRyadomApp extends StatelessWidget {
  const MamaRyadomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mama Ryadom',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/account': (context) => const AccountScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/home': (context) => const ChatListScreen(),
      },
    );
  }
}
