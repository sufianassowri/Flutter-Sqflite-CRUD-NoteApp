import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_app/database_helper.dart';
import 'item_model.dart';

class UIController extends GetxController {
  //create list of your model so that UI can see change in model
  final RxList<Note> NoteItems = RxList<Note>();

  // final RxList<Item> items = RxList<Item>();
  List<Note> noteList = [];
  late DatabaseHelper dbhelper;

  Future<int> insertNote(Note note) async {
    dbhelper = await DatabaseHelper();
    late int insertedR;
    if (note.title.isEmpty || note.description.isEmpty) {
      // print("Fields are Empty");
    } else {
      insertedR = await dbhelper.insertData(note);
      //you can call  insertd(),getUpdated() and deleted function to get affected row
      getDeletedRow(insertedR);
      // print("inserted $insertedR");
      //it is better if you use void return  to call update()
      fetchData();
    }
    return insertedR;
  }

  Future<int> getDeletedRow(int affectedRow) async {
    return affectedRow;
  }

  Future<int> getUpdatedRow(int affectedRow) async {
    return affectedRow;
  }

  Future<int> getInsertdRow(int affectedRow) async {
    return affectedRow;
  }

  //now update and delete
  Future<int> updateNote(Note note) async {
    dbhelper = await DatabaseHelper();
    int updatedR = await dbhelper.updateData(note);
    // print("updated $updatedR");
    fetchData();
    return updatedR;
  }

  Future<int> deleteNote(int id) async {
    dbhelper = await DatabaseHelper();
    int deletedR = 0;
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text("Delete confirmation?"),
        content: Text("Are you sure to delte this Note?"),
        actions: [
          TextButton(
            onPressed: () async {
              deletedR = await dbhelper.deleteData(id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Deleted  ${id}'),
                    backgroundColor: Colors.red),
              );
              fetchData();
              Get.back(); //will close ethe dialog
            },
            child: Text("yes"),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Not Deleted '),
                    backgroundColor: Colors.green),
              );
              Get.back(); //will close ethe dialog
            },
            child: Text("No"),
          ),
        ],
      ),
    );

    return deletedR;
  }

  //get ref to db
  Future<List<Note>> fetchData() async {
    dbhelper = await DatabaseHelper();
    noteList = await dbhelper.fetchData();
    // update();
    NoteItems.value = noteList;
    return noteList;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    dbhelper = DatabaseHelper();
    fetchData();
  }
}
