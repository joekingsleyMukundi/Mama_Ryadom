import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final isTablet = screenWidth > 600;
    final isLandscape = size.width > size.height;

    // Responsive values
    final horizontalPadding = _getHorizontalPadding(screenWidth);
    final profileRadius = _getProfileRadius(screenWidth, isTablet);
    final titleFontSize = _getTitleFontSize(screenWidth, isTablet);
    final nameFontSize = _getNameFontSize(screenWidth, isTablet);
    final menuItemFontSize = _getMenuItemFontSize(screenWidth, isTablet);
    final logoutFontSize = _getLogoutFontSize(screenWidth, isTablet);
    final iconSize = _getIconSize(screenWidth, isTablet);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.text,
            size: isTablet ? 28 : 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.text,
            fontWeight: FontWeight.w800,
            fontSize: titleFontSize,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(height: isLandscape ? 16 : 28),

                      /// Profile Section
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: profileRadius,
                              backgroundImage: const AssetImage(
                                'assets/images/profile.png',
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(height: isTablet ? 20 : 16),
                            Text(
                              'Ekaterina',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: nameFontSize,
                                    color: AppColors.text,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: isLandscape ? 32 : 56),

                      /// Menu Items
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: Column(
                            children: [
                              _buildMenuItem(
                                icon: Icons.person_outline,
                                title: 'Account',
                                fontSize: menuItemFontSize,
                                iconSize: iconSize,
                                onTap: () =>
                                    Navigator.pushNamed(context, '/account'),
                              ),
                              const Divider(color: AppColors.inputBorder),

                              _buildMenuItem(
                                icon: Icons.notifications_outlined,
                                title: 'Notifications',
                                fontSize: menuItemFontSize,
                                iconSize: iconSize,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/notifications',
                                ),
                              ),
                              const Divider(color: AppColors.inputBorder),

                              _buildMenuItem(
                                icon: Icons.help_outline,
                                title: 'Help',
                                fontSize: menuItemFontSize,
                                iconSize: iconSize,
                                onTap: () =>
                                    Navigator.pushNamed(context, '/help'),
                              ),
                              const Divider(color: AppColors.inputBorder),

                              const Spacer(),
                            ],
                          ),
                        ),
                      ),

                      /// Logout
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: isLandscape ? 16 : 32,
                          left: horizontalPadding,
                          right: horizontalPadding,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              // TODO: Add logout logic
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: AppColors.accent,
                                  size: iconSize,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Log Out',
                                  style: TextStyle(
                                    color: AppColors.accent,
                                    fontSize: logoutFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required double fontSize,
    required double iconSize,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 16,
      leading: Icon(
        icon,
        color: AppColors.text.withOpacity(0.6),
        size: iconSize,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.text,
          fontSize: fontSize,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.text.withOpacity(0.4),
        size: iconSize,
      ),
      onTap: onTap,
    );
  }

  // Responsive helper methods
  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth < 360) return 16.0;
    if (screenWidth > 600) return screenWidth * 0.08;
    return screenWidth * 0.06;
  }

  double _getProfileRadius(double screenWidth, bool isTablet) {
    if (screenWidth < 360) return 56.0;
    if (isTablet) return 80.0;
    return 72.0;
  }

  double _getTitleFontSize(double screenWidth, bool isTablet) {
    if (screenWidth < 360) return 20.0;
    if (isTablet) return 32.0;
    return 24.0;
  }

  double _getNameFontSize(double screenWidth, bool isTablet) {
    if (screenWidth < 360) return 18.0;
    if (isTablet) return 26.0;
    return 20.0;
  }

  double _getMenuItemFontSize(double screenWidth, bool isTablet) {
    if (screenWidth < 360) return 14.0;
    if (isTablet) return 18.0;
    return 16.0;
  }

  double _getLogoutFontSize(double screenWidth, bool isTablet) {
    if (screenWidth < 360) return 14.0;
    if (isTablet) return 18.0;
    return 16.0;
  }

  double _getIconSize(double screenWidth, bool isTablet) {
    if (screenWidth < 360) return 20.0;
    if (isTablet) return 26.0;
    return 24.0;
  }
}
