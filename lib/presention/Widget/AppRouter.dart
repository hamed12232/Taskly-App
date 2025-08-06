import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/Constant/String.dart';
import 'package:to_do_list/business_logic/Cubit/notes_cubit.dart';
import 'package:to_do_list/data/Storage/SqlDb.dart';
import 'package:to_do_list/data/model/note.dart';
import 'package:to_do_list/presention/Screen/AddNoteScreen.dart';
import 'package:to_do_list/presention/Screen/AnimatedDrawer.dart';
import 'package:to_do_list/presention/Screen/EditNoteScreen.dart';
import 'package:to_do_list/presention/Screen/FavouriteScreen.dart';
import 'package:to_do_list/presention/Screen/HomeScreen.dart';
import 'package:to_do_list/presention/Screen/NavigationScreen.dart';
import 'package:to_do_list/presention/Screen/SettingScreen.dart';
import 'package:to_do_list/presention/Screen/SplashScreen.dart';

class AppRouter {
  SqlDb sqlDb = SqlDb();

  Route? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case myHomeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
                create: (context) => NotesCubit(sqlDb),
                child:  Splashscreen()));
      case navigationScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
                create: (context) => NotesCubit(sqlDb),
                child: const Navigationscreen()));
      case homeScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
              create: (context) => NotesCubit(sqlDb),
              child: const Homescreen()),
        );
      case addNote:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (BuildContext context) => NotesCubit(sqlDb),
              child: const AddNoteScreen()),
        );
      case editNote:
        final note = setting.arguments as Note;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (BuildContext context) => NotesCubit(sqlDb),
              child: EditNoteScreen(
                note: note,
              )),
        );
      case settingScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (BuildContext context) => NotesCubit(sqlDb),
                child: const Settingscreen()));
      case favouriteScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (BuildContext context) => NotesCubit(sqlDb),
                child: const Favouritescreen()));
    }
    return null;
  }
}
