import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/presention/Screen/FavouriteScreen.dart';
import 'package:to_do_list/presention/Screen/NavigationScreen.dart';

class MyHomePageDrawer extends StatefulWidget {
  const MyHomePageDrawer({super.key});

  @override
  State<MyHomePageDrawer> createState() => _MyHomePageDrawerState();
}

class _MyHomePageDrawerState extends State<MyHomePageDrawer> {
  Widget page = const Navigationscreen();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return ZoomDrawer(
      menuScreen: MenuScreen(
        onPage: (v) {
          setState(() {
            page = v;
          });
        },
      ),
      mainScreen: page,
      borderRadius: 24,
      angle: 0,
      showShadow: true,
      drawerShadowsBackgroundColor: ColorPalette.primary.withOpacity(0.5),
      menuBackgroundColor: ColorPalette.primary,
      //slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key, required this.onPage});
  
  final Function(Widget) onPage;

  final List<MenuListItem> pagesMenu = [
    MenuListItem(
      icon: Icons.home_rounded,
      title: "Home".tr(),
      widget: const Navigationscreen(),
    ),
    MenuListItem(
      icon: Icons.favorite_rounded,
      title: "Favorites".tr(),
      widget: const Favouritescreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: ColorPalette.primary.withOpacity(0.5),
        body: SafeArea(
          child: Column(
           
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
               
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: ColorPalette.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: ColorPalette.lightSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'My Task'.tr(),
                      style: TextStyle(
                        color: ColorPalette.getTextColor(isDarkMode),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: pagesMenu.length,
                  itemBuilder: (context, index) {
                    final item = pagesMenu[index];
                    return ListTile(
                      onTap: () {
                        onPage(item.widget);
                        ZoomDrawer.of(context)!.close();
                      },
                      leading: Icon(
                        item.icon,
                        color: ColorPalette.getTextColor(isDarkMode),
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                          color: ColorPalette.getTextColor(isDarkMode),
                          fontSize: 16,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuListItem {
  final IconData icon;
  final String title;
  final Widget widget;

  MenuListItem({
    required this.icon,
    required this.title,
    required this.widget,
  });
}
