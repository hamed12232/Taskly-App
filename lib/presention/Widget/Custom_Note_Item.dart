import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/Constant/String.dart';
import 'package:to_do_list/business_logic/Cubit/notes_cubit.dart';
import 'package:to_do_list/data/model/note.dart';
import 'package:to_do_list/presention/Widget/Add_Fovourite_task.dart';

class CustomNoteItem extends StatefulWidget {
  const CustomNoteItem({super.key, required this.note});
  final Note note;

  @override
  State<CustomNoteItem> createState() => _CustomNoteItemState();
}

class _CustomNoteItemState extends State<CustomNoteItem> {
  bool? isFavorite;

  @override
  void initState() {
    super.initState();
    _updateFavoriteStatus();
  }

  void _updateFavoriteStatus() {
    if (!mounted) return;
    
    setState(() {
      isFavorite = BlocProvider.of<NotesCubit>(context).isNoteFavorite(widget.note);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return BlocListener<NotesCubit, NotesState>(
      listener: (context, state) {
        if (state is NotesSuccess) {
          _updateFavoriteStatus();
        }
      },
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, editNote, arguments: widget.note),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ColorPalette.getSurfaceColor(isDarkMode),
            boxShadow: [
              BoxShadow(
                color: Color(widget.note.color),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 8,
                  decoration: BoxDecoration(
                    color: Color(widget.note.color),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.note.title,
                                style: TextStyle(
                                  color: ColorPalette.getTextColor(isDarkMode),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            AddFavoriteTask(
                              isFavorite: isFavorite ?? false,
                              onTap: _toggleFavorite,
                            ),
                          ],
                        ),
                        if (widget.note.subTitle.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            widget.note.subTitle,
                            style: TextStyle(
                              color: ColorPalette.getTextColor(isDarkMode, isSecondary: true),
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const SizedBox(height: 16),
                        Text(
                          widget.note.date,
                          style: TextStyle(
                            color: ColorPalette.getTextColor(isDarkMode, isSecondary: true),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _toggleFavorite() async {
    if (!mounted) return;
    
    try {
      final notesCubit = BlocProvider.of<NotesCubit>(context);
      final newFavoriteState = !(isFavorite ?? false);
      
      setState(() {
        isFavorite = newFavoriteState;
      });
      
      if (newFavoriteState) {
        await notesCubit.addNote(widget.note, "Favourite");
      } else {
        final favoriteNote = notesCubit.favourite.firstWhere(
          (favNote) => 
            favNote.title == widget.note.title &&
            favNote.subTitle == widget.note.subTitle &&
            favNote.date == widget.note.date &&
            favNote.color == widget.note.color,
          orElse: () => widget.note,
        );
        await notesCubit.deleteNote(favoriteNote, "Favourite");
      }
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        isFavorite = !(isFavorite ?? false);
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to update favorite status',
            style: TextStyle(
              color: ColorPalette.getTextColor(true),
            ),
          ),
          backgroundColor: ColorPalette.error,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }
}
