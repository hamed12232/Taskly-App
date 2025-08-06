import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/business_logic/Cubit/notes_cubit.dart';
import 'package:to_do_list/data/model/note.dart';
import 'package:to_do_list/presention/Widget/Color_listView.dart';
import 'package:to_do_list/presention/Widget/CustomText_field.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    super.key,
    required this.note,
  });
  final Note note;
  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  String? title, subtitle;
  @override
  void initState() {
    super.initState();
    title = widget.note.title;
    subtitle = widget.note.subTitle;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.getSurfaceColor(isDarkMode),
        actions: [
          IconButton(
              onPressed: () async {
                var currentDate = DateTime.now();
                var formattedTime = DateFormat.yMd().format(currentDate);
                await BlocProvider.of<NotesCubit>(context).editNote(Note(
                    id: widget.note.id,
                    title: title!,
                    subTitle: subtitle!,
                    color: Colors.black.value,
                    date: formattedTime));
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(
                Icons.edit,
                color: ColorPalette.primary,
              ))
        ],
      ),
      backgroundColor: ColorPalette.getBackgroundColor(isDarkMode),
      body: ListView(
        children: [
          const ColorsListView(),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
              label: 'Title'.tr(),
              hintText: widget.note.title,
              maxLines: 1,
              onChanged: (v) {
                title = v;
              }),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
              label: 'Content'.tr(),
              hintText: widget.note.subTitle,
              maxLines: 10,
              onChanged: (v) {
                subtitle = v;
              }),
        ],
      ),
    );
  }
}
