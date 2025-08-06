import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/business_logic/Cubit/notes_cubit.dart';
import 'package:to_do_list/data/model/note.dart';
import 'package:to_do_list/presention/Widget/Custom_Note_Item.dart';

class CustomBlocBuilderNotes extends StatelessWidget {
  const CustomBlocBuilderNotes({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state is NotesLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorPalette.primary,
            ),
          );
        } else if (state is NotesSuccess) {
          if (state.notes.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey<Note>(state.notes[index]),
                  background: Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.error,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      headerAnimationLoop: false,
                      animType: AnimType.bottomSlide,
                      title: 'Delete Note'.tr(),
                      desc: 'Are you sure you want to delete this note?'.tr(),
                      buttonsTextStyle: const TextStyle(color: Colors.black),
                      showCloseIcon: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        BlocProvider.of<NotesCubit>(context)
                            .deleteNote(state.notes[index], "Notes");
                      },
                      btnCancelText: 'No'.tr(),
                      btnOkText: 'Yes'.tr(),
                      btnCancelColor: Colors.grey,
                      btnOkColor: ColorPalette.error,
                    ).show();
                    return Future.value(false);
                  },
                  child: CustomNoteItem(
                    note: state.notes[index],
                  ),
                );
              },
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/Empty-amico.png"),
                Text(
                  "No notes found".tr(),
                  style: TextStyle(
                    color: ColorPalette.getTextColor(isDarkMode),
                    fontSize: 16,
                  ),
                ),
              ],
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
            child: Column(
              children: [
                Image.asset("assets/grammar correction-amico.png"),
                Text(
                  "Start Adding Your Notes".tr(),
                  style: TextStyle(
                    color: ColorPalette.getTextColor(isDarkMode),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
