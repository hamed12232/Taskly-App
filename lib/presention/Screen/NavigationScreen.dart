import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/presention/Screen/AddNoteScreen.dart';
import 'package:to_do_list/presention/Screen/HomeScreen.dart';
import 'package:to_do_list/presention/Screen/SettingScreen.dart';

class Navigationscreen extends StatefulWidget {
  const Navigationscreen({super.key});

  @override
  State<Navigationscreen> createState() => _NavigationscreenState();
}

class _NavigationscreenState extends State<Navigationscreen> {
  int currentIndex = 0;
  final List<Widget> pages = const [
    Homescreen(),
    AddNoteScreen(),
    Settingscreen()
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: ColorPalette.getBackgroundColor(isDarkMode),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(
            color: ColorPalette.primary,
          ),
        ),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: ColorPalette.getSurfaceColor(isDarkMode),
          buttonBackgroundColor: ColorPalette.primary.withOpacity(0.1),
          height: 60,
          index: currentIndex,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          items: [
            Icon(
              Icons.home_rounded,
              color: currentIndex == 0 
                  ? ColorPalette.primary
                  : ColorPalette.getTextColor(isDarkMode, isSecondary: true),
              size: 30,
            ),
            Icon(
              Icons.add_circle_rounded,
              color: currentIndex == 1 
                  ? ColorPalette.primary
                  : ColorPalette.getTextColor(isDarkMode, isSecondary: true),
              size: 30,
            ),
            Icon(
              Icons.settings_rounded,
              color: currentIndex == 2 
                  ? ColorPalette.primary
                  : ColorPalette.getTextColor(isDarkMode, isSecondary: true),
              size: 30,
            ),
          ],
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }
}
