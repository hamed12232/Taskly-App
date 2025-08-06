import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/business_logic/Cubit/notes_cubit.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/presention/Widget/CustomBlocBuilderNotes.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with RouteAware {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesCubit>(context).showNotes("Notes");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    BlocProvider.of<NotesCubit>(context).showNotes("Notes");
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: ColorPalette.getBackgroundColor(isDarkMode),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => ZoomDrawer.of(context)!.toggle(),
          icon: Icon(
            Icons.menu,
            color: ColorPalette.getTextColor(isDarkMode),
          ),
        ),
        backgroundColor: ColorPalette.getSurfaceColor(isDarkMode),
        elevation: 0,
        title: Text(
          'Taskly'.tr(),
          style: TextStyle(
            color: ColorPalette.getTextColor(isDarkMode),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: CustomBlocBuilderNotes(isDarkMode: isDarkMode),
    );
  }
}
