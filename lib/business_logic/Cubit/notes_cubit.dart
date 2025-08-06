import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/data/Storage/SqlDb.dart';
import 'package:to_do_list/data/model/note.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this.sqlDb) : super(NotesInitial());
  SqlDb sqlDb;

  Color? color;
  List<Note> notes = [];
  List<Note> favourite = [];

  Future<void> addNote(Note note, String table) async {
    emit(NotesLoading());

    try {
      if (table == "Notes") {
        // For new notes, use the selected color or default
        note.color = color?.value ?? ColorPalette.noteColors[0].value;
        int id = await sqlDb.insertData(table, note.toMap());
        note.id = id;
        notes.add(note);
        emit(NoteAddedSuccess(notes: notes, favourite: favourite));
      } else {
        // For favorites, preserve the original note's color
        final favoriteNote = Note(
          title: note.title,
          subTitle: note.subTitle,
          color: note.color, // Use the original note's color
          date: note.date,
        );
        int id = await sqlDb.insertData(table, favoriteNote.toMap());
        favoriteNote.id = id;
        favourite.add(favoriteNote);
        emit(NotesSuccess(notes: notes, favourite: favourite));
      }
    } catch (e) {
      emit(NotesFailure(errorMessage: e.toString()));
    }
  }

  bool isNoteFavorite(Note note) {
    return favourite.any((favNote) => 
      favNote.title == note.title &&
      favNote.subTitle == note.subTitle &&
      favNote.date == note.date &&
      favNote.color == note.color
    );
  }

  Future<void> showNotes(String table) async {
    emit(NotesLoading());
    try {
      if (table == "Notes") {
        List<Map<String, dynamic>> response = await sqlDb.readData(table);
        notes = response.map((e) => Note.fromMap(e)).toList();
      } else {
        List<Map<String, dynamic>> response = await sqlDb.readData(table);
        favourite = response.map((e) => Note.fromMap(e)).toList();
      }
      emit(NotesSuccess(notes: notes, favourite: favourite));
    } catch (e) {
      emit(NotesFailure(errorMessage: e.toString()));
    }
  }

  Future<void> editNote(Note note) async {
    note.color = color?.value ?? ColorPalette.noteColors[0].value;
    try {
      await sqlDb.updateData('Notes', note.toMap(), 'id = ?', [note.id]);
      int index = notes.indexWhere((n) => n.id == note.id);
      if (index != -1) {
        notes[index] = note;
      }
      //  emit(NotesSuccess(notes: notes));
    } catch (e) {
      emit(NotesFailure(errorMessage: e.toString()));
    }
  }

  Future<void> deleteNote(Note note, String table) async {
    try {
      if (table == "Notes") {
        await sqlDb.deleteData(table, 'id = ?', [note.id]);
        notes.removeWhere((n) => n.id == note.id);
      } else {
        await sqlDb.deleteData(table, 'id = ?', [note.id]);
        favourite.removeWhere((n) => n.id == note.id);
      }
      emit(NotesSuccess(notes: notes, favourite: favourite));
    } catch (e) {
      emit(NotesFailure(errorMessage: e.toString()));
    }
  }
}
