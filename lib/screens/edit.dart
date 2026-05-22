import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/components/buttons.dart';
import 'package:notes_app/components/textfield.dart';
import 'package:notes_app/database/note.dart';
import 'package:notes_app/database/database_helper.dart';

class EditNote extends StatefulWidget {
  final String appbartitle;
  final Note note;
  const EditNote({super.key, required this.note, required this.appbartitle});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  static final _priorities = ["high", "low"];
  String selectedPriority = "low";
  DatabaseHelper databaseHelper = DatabaseHelper();

  late TextEditingController titleController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    noteController = TextEditingController();
    titleController.text = widget.note.title ?? "";
    noteController.text = widget.note.description ?? "";
    selectedPriority = updatePriorityAsString(widget.note.priority ?? 2);
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 127, 78, 212),
        title: Text(widget.appbartitle, style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 12),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                items: _priorities.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                value: selectedPriority,
                onChanged: (value) {
                  setState(() {
                    selectedPriority = value!;

                    if (value == "high") {
                      widget.note.priority = 1;
                    } else {
                      widget.note.priority = 2;
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 10),

            CustTextField(
              hintText: "Title",
              controller: titleController,
              maxLines: 1,
              onChanged: (value) {
                updateTitle();
              },
            ),
            SizedBox(height: 10),

            CustTextField(
              hintText: "Description",
              controller: noteController,
              maxLines: 6,
              onChanged: (value) {
                updateDescription();
              },
            ),
            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: CustButton(
                    text: "Save",
                    onPressed: () {
                      _save();
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustButton(
                    text: "Delete",
                    onPressed: () {
                      _delete();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case "high":
        widget.note.priority = 1;
        break;
      case "low":
        widget.note.priority = 2;
        break;
    }
  }

  String updatePriorityAsString(int value) {
    switch (value) {
      case 1:
        return _priorities[0];
      case 2:
        return _priorities[1];
      default:
        return _priorities[1];
    }
  }

  void updateTitle() {
    widget.note.title = titleController.text;
  }

  void updateDescription() {
    widget.note.description = noteController.text;
  }

  void _save() async {
    widget.note.title = titleController.text;
    widget.note.description = noteController.text;
    widget.note.date = DateFormat.yMMMd().format(DateTime.now());
    widget.note.priority = selectedPriority == "high" ? 1 : 2;
    int result;
    if (widget.note.id != null) {
      result = await databaseHelper.updateNote(widget.note);
    } else {
      result = await databaseHelper.insertNote(widget.note);
    }

    if (result != 0) {
      movetoLastScreen();
    } else {
      _showAlertDialog("Status", "Problem saving Note");
    }
  }

  void _delete() async {
    if (widget.note.id == null) {
      _showAlertDialog("Status", "No Note was deleted");
      return;
    }
    int result = await databaseHelper.deleteNote(widget.note.id ?? 0);
    if (result != 0) {
      movetoLastScreen();
    } else {
      _showAlertDialog("Status", "Problem deleting Note");
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void movetoLastScreen() {
    Navigator.pop(context, true);
  }
}
