import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/business_logic/Cubit/notes_cubit.dart';
import 'package:to_do_list/data/model/note.dart';
import 'package:to_do_list/presention/Widget/Custom_Note_Item.dart';

class Favouritescreen extends StatefulWidget {
  const Favouritescreen({
    super.key,
  });

  @override
  State<Favouritescreen> createState() => _FavouritescreenState();
}

class _FavouritescreenState extends State<Favouritescreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesCubit>(context).showNotes("Favourite");
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: ColorPalette.getBackgroundColor(isDarkMode),
      appBar: AppBar(
        backgroundColor: ColorPalette.getSurfaceColor(isDarkMode),
        elevation: 0,
        leading: IconButton(
          onPressed: () => ZoomDrawer.of(context)!.toggle(),
          icon: Icon(
            Icons.menu,
            color: ColorPalette.getTextColor(isDarkMode),
          ),
        ),
        title: Text(
          'Favorites'.tr(),
          style: TextStyle(
            color: ColorPalette.getTextColor(isDarkMode),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorPalette.primary,
              ),
            );
          } else if (state is NotesSuccess) {
            if (state.favourite.isNotEmpty) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: state.favourite.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey<Note>(state.favourite[index]),
                    background: Container(
                      color: ColorPalette.error,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      BlocProvider.of<NotesCubit>(context)
                          .deleteNote(state.favourite[index], "Favourite");
                    },
                    child: CustomNoteItem(
                      note: state.favourite[index],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width:100,
                      child: Image.asset("assets/like.png")),
                    const SizedBox(height: 16),
                    Text(
                      "No favorites yet".tr(),
                      style: TextStyle(
                        color: ColorPalette.getTextColor(isDarkMode),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Add notes to favorites to see them here".tr(),
                      style: TextStyle(
                        color: ColorPalette.getTextColor(isDarkMode, isSecondary: true),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }
          } else if (state is NotesFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(
                  color: ColorPalette.error,
                  fontSize: 16,
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                "Start adding notes to favorites".tr(),
                style: TextStyle(
                  color: ColorPalette.getTextColor(isDarkMode),
                  fontSize: 16,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
