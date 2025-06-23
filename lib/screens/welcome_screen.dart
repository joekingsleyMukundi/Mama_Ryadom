import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isSmallPhone = screenHeight < 700;
    final isLargePhone = screenHeight > 900;

    return Scaffold(
      backgroundColor: const Color(0xFF6DCDB1), // Mint green/teal background
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 48.0 : (screenWidth * 0.06),
          ),
          child: Column(
            children: [
              // Header positioned at top-left
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: isSmallPhone ? screenHeight * 0.04 : screenHeight * 0.06,
                  bottom: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w800,
                            fontSize: isTablet
                                ? 68
                                : isSmallPhone
                                ? 48
                                : isLargePhone
                                ? 62
                                : 58,
                            height: 1.0,
                          ),
                    ),
                    Text(
                      'Mom!',
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w800,
                            fontSize: isTablet
                                ? 68
                                : isSmallPhone
                                ? 48
                                : isLargePhone
                                ? 62
                                : 58,
                            height: 1.0,
                          ),
                    ),
                  ],
                ),
              ),

              // Flexible space for content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Subtitle
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ),
                      child: Text(
                        'Ask advice, support,\nshare with others.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black54,
                          fontSize: isTablet
                              ? 22
                              : isSmallPhone
                              ? 16
                              : 18,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // Mother and baby image - responsive sizing
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: isSmallPhone
                              ? screenHeight * 0.35
                              : screenHeight * 0.4,
                          maxWidth: screenWidth * 0.8,
                        ),
                        child: Image.asset(
                          'assets/images/mother_child.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // Start button
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: isTablet ? 20 : 16,
                            ),
                            minimumSize: Size(
                              double.infinity,
                              isTablet ? 60 : 50,
                            ),
                          ),
                          child: Text(
                            'Start',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: isTablet ? 18 : 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom spacing
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
