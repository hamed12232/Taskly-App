part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesSuccess extends NotesState {
  final List<Note> notes;
  final List<Note> favourite;

  NotesSuccess({required this.notes, required this.favourite});
}

class NoteAddedSuccess extends NotesSuccess {
  NoteAddedSuccess({required super.notes, required super.favourite});
}

class NotesFailure extends NotesState {
  final String errorMessage;

  NotesFailure({required this.errorMessage});
}
