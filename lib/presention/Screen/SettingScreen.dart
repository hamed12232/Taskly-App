import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/business_logic/Theme_Cubit.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});
  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  bool isDarkMode = false;
  String selectedLanguage = 'English'.tr();

  Widget _buildTitle(String text) => Text(
        text.tr(),
        style: TextStyle(
          color: ColorPalette.getTextColor(isDarkMode),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _buildThemeSwitch() => Container(
        decoration: BoxDecoration(
          color: ColorPalette.getSurfaceColor(isDarkMode),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
        ),
        child: ListTile(
          leading: const Icon(Icons.dark_mode_rounded, color: ColorPalette.primary, size: 24),
          title: Text("Dark Mode".tr(), style: TextStyle(color: ColorPalette.getTextColor(isDarkMode), fontSize: 16)),
          trailing: Switch.adaptive(
            value: isDarkMode,
            activeColor: ColorPalette.primary,
            onChanged: (value) => setState(() {
              isDarkMode = value;
              context.read<ThemeCubit>().toggleTheme();
            }),
          ),
        ),
      );

  Widget _buildLanguageOption(String language, String label) {
    final isSelected = selectedLanguage == language;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          final locale = language == 'English' ? const Locale('en') : const Locale('ar');
          context.setLocale(locale);
          setState(() {
            selectedLanguage = language;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: ColorPalette.getSurfaceColor(isDarkMode),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? ColorPalette.primary : Colors.transparent, width: 2),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: ColorPalette.getTextColor(isDarkMode),
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? ColorPalette.primary : ColorPalette.getTextColor(isDarkMode, isSecondary: true),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? ColorPalette.primary : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: ColorPalette.getBackgroundColor(isDarkMode),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Settings'.tr(),
            style: TextStyle(
              color: ColorPalette.getTextColor(isDarkMode),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle("Theme"),
            const SizedBox(height: 12),
            _buildThemeSwitch(),
            const SizedBox(height: 32),
            _buildTitle("Language"),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildLanguageOption('English', 'English'.tr()),
                const SizedBox(width: 12),
                _buildLanguageOption('Arabic', 'العربية'.tr()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
