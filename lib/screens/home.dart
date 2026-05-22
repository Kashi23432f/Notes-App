import 'package:flutter/material.dart';
import 'package:notes_app/screens/edit.dart';
import 'dart:async';
import 'package:notes_app/database/note.dart';
import 'package:notes_app/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes List", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 127, 78, 212),
      ),
      body: getNoteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Note("", "", 2, ""), "Add Note");
        },

        backgroundColor: const Color.fromARGB(255, 127, 78, 212),
        tooltip: "Add note",
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  ListView getNoteList() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2.0,
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(noteList[index].priority ?? 0),
              child: getPriorityIcon(noteList[index].priority ?? 0),
            ),
            title: Text(noteList[index].title ?? ""),
            subtitle: Text(noteList[index].description ?? ""),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: const Color.fromARGB(255, 90, 85, 85),
              ),
              onTap: () {
                _delete(context, noteList[index]);
              },
            ),
            onTap: () {
              navigateToDetail(noteList[index], "Edit Note");
            },
          ),
        );
      },
    );
  }

  // return prioriyty colors
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        // ignore: dead_code
        break;

      case 2:
        return Colors.yellow;
        // ignore: dead_code
        break;

      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        // ignore: dead_code
        break;

      case 2:
        return Icon(Icons.keyboard_arrow_right);
        // ignore: dead_code
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id ?? 0);
    if (result != 0) {
      _showSnackBar(context, "Note deleted Successfully");
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void navigateToDetail(Note note, String title) async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNote(note: note, appbartitle: title),
      ),
    );
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          count = noteList.length;
        });
      });
    });
  }
}
