import 'package:flutter/material.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({super.key, required this.isActive, required this.color});
  final bool isActive;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: isActive ? 38 : 35,
      height: isActive ? 38 : 35,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive 
              ? ColorPalette.primary
              : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: isDarkMode 
                  ? Colors.black26
                  : color.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
        ],
      ),
      child: isActive
          ? Icon(
              Icons.check,
              color: color.computeLuminance() > 0.5 
                  ? Colors.black54
                  : Colors.white,
              size: 20,
            )
          : null,
    );
  }
}
