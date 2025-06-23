import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF6DCDB1),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                const SizedBox(height: 48),

                /// === Logo ===
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Colors.black87,
                      size: isTablet ? 82 : 66,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mama',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: isTablet ? 40 : 32,
                                color: Colors.black87,
                              ),
                        ),
                        Text(
                          'Ryadom',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: isTablet ? 40 : 32,
                                color: Colors.black87,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                /// Expanded scrollable form
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, innerConstraints) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.06,
                          right: screenWidth * 0.06,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: innerConstraints.maxHeight - 72,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /// Welcome Text
                                Text(
                                  'Welcome',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: isTablet ? 30 : 26,
                                        color: const Color.fromARGB(
                                          194,
                                          0,
                                          0,
                                          0,
                                        ),
                                      ),
                                ),
                                Text(
                                  'Back!',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: isTablet ? 30 : 26,
                                        color: const Color.fromARGB(
                                          194,
                                          0,
                                          0,
                                          0,
                                        ),
                                      ),
                                ),

                                const SizedBox(height: 32),

                                /// Email Field
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: _inputDecoration(
                                    'Email',
                                    const Icon(Icons.email_outlined),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                /// Password Field
                                TextFormField(
                                  obscureText: true,
                                  decoration: _inputDecoration(
                                    'Password',
                                    const Icon(Icons.lock_outline),
                                  ),
                                ),

                                /// Forgot Password Link
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/forgot-password',
                                      );
                                    },
                                    child: const Text(
                                      'Forgot password?',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 24),

                                /// Continue Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/chats');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.accent,
                                      foregroundColor: Colors.white,
                                      elevation: 2,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 18,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      shadowColor: Colors.black26,
                                    ),
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),

                                /// Create Account
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: const Text(
                                    'Create Account',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Color.fromARGB(186, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Common input decoration
  InputDecoration _inputDecoration(String hint, Widget icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
