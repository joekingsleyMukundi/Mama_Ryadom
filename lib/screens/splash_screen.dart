import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
  }

  void _navigateToWelcome() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/welcome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 800; // Better tablet detection for landscape

    // Responsive sizing optimized for landscape
    final iconSize = isTablet ? 100.0 : (screenHeight * 0.15).clamp(50.0, 80.0);
    final fontSize = isTablet ? 42.0 : (screenHeight * 0.08).clamp(24.0, 36.0);
    final spacing = isTablet ? 32.0 : 20.0;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: iconSize,
                  color: Colors.black,
                ),
                SizedBox(width: spacing),
                _buildTitleColumn(context, fontSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleColumn(BuildContext context, double fontSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mama',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            letterSpacing: 1.2,
          ),
        ),
        Text(
          'Ryadom',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
