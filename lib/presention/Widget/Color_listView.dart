import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/business_logic/Cubit/notes_cubit.dart';
import 'package:to_do_list/presention/Widget/Color_item.dart';

class ColorsListView extends StatefulWidget {
  const ColorsListView({
    super.key,
  });

  @override
  State<ColorsListView> createState() => _ColorsListViewState();
}

class _ColorsListViewState extends State<ColorsListView> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animations = List.generate(
      ColorPalette.noteColors.length,
      (index) => Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.1,
            (index + 1) * 0.1,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Color'.tr(),
            style: TextStyle(
              color: ColorPalette.getTextColor(isDarkMode),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 60,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: ColorPalette.noteColors.length,
            itemBuilder: (context, index) {
              return ScaleTransition(
                scale: _animations[index],
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                      BlocProvider.of<NotesCubit>(context).color =
                          ColorPalette.noteColors[index];
                    });
                  },
                  child: ColorItem(
                    isActive: currentIndex == index,
                    color: ColorPalette.noteColors[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
