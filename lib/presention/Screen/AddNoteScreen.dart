import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/business_logic/Cubit/notes_cubit.dart';
import 'package:to_do_list/data/model/note.dart';
import 'package:to_do_list/presention/Widget/Color_listView.dart';
import 'package:to_do_list/presention/Widget/CustomText_field.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});
  
  @override
  State<AddNoteScreen> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  String? content;
  bool _isSubmitting = false;

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        final currentDate = DateTime.now();
        final formattedTime = DateFormat.yMd().format(currentDate);
        final notesCubit = BlocProvider.of<NotesCubit>(context);
        
        await notesCubit.addNote(
          Note(
            title: title!,
            subTitle: content!,
            date: formattedTime,
            color: notesCubit.color?.value ?? ColorPalette.noteColors[0].value,
          ),
          "Notes",
        );
                            
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Note".tr(),
          style: TextStyle(
            color: ColorPalette.getTextColor(isDarkMode),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ColorPalette.getSurfaceColor(isDarkMode),
        elevation: 0,
        
      ),
      backgroundColor: ColorPalette.getBackgroundColor(isDarkMode),
      body: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
          if (state is NoteAddedSuccess) {
            showDialog().then((_) {
              if (mounted && Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            });
          } else if (state is NotesFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
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
        },
        builder: (context, state) {
          if (state is NotesLoading || _isSubmitting) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorPalette.primary,
              ),
            );
          }
          
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const ColorsListView(),
                const SizedBox(height: 24),
                CustomTextField(
                  label: "Title".tr(),
                  maxLines: 1,
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: "Content".tr(),
                  maxLines: 10,
                  onChanged: (value) {
                    setState(() {
                      content = value;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isSubmitting ? null : _submitForm,
        backgroundColor: _isSubmitting 
            ? ColorPalette.primary.withOpacity(0.6)
            : ColorPalette.primary,
        elevation: isDarkMode ? 4 : 6,
        child: _isSubmitting
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(
                Icons.save_rounded,
                color: Colors.white,
              ),
      ),
    );
  }
   Future<void> showDialog(){
    return AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: 'Success'.tr(),
      desc: "Note has been added successfully!".tr(),
      btnOkOnPress: () {
        // Dialog will auto-dismiss when OK is pressed
      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (_) {
        // Dialog dismissed
      },
    ).show();
  }
}
