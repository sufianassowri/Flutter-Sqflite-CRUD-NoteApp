import 'package:flutter/material.dart';
import 'package:my_flutter_app/item_model.dart';
import 'package:my_flutter_app/mycontroller.dart';
import 'package:get/get.dart';

import 'database_helper.dart';

class UserForm extends StatelessWidget {
  // UserForm({super.key});
  String AppBarTitile;
  final Note? note;

  UserForm({super.key, required this.AppBarTitile, this.note});

  // final Item? item;
  final _formKey = GlobalKey<FormState>();
  final UIController mycontroller = Get.find<UIController>(); //find controller
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final note = this.note;
    if (note != null) {
      titleController.text = note.title;
      descriptionController.text = note.description;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(AppBarTitile),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  readOnly: false,
                  autofocus: true,
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      gapPadding: 4.0,
                    ),
                    labelText: "Enter Title",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please Insert Title')),
                      );
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  readOnly: false, //enabling copy and paste
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      gapPadding: 4.0,
                    ),
                    labelText: "Enter Description",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final newNote = Note(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                  );
                                  final note = this.note;
                                  if (note != null) {
                                    newNote.id = note.id;
                                    mycontroller.updateNote(newNote);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Updated ${note.title}')),
                                    );
                                  } else {
                                    int rowId =
                                        await mycontroller.insertNote(newNote);
                                    if (rowId > 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Saved ${newNote.title}')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text('Not Saved ')),
                                      );
                                    }
                                  }
                                  Get.back();
                                }
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purpleAccent),
                              onPressed: () {
                                descriptionController.text = "";
                                titleController.text = "";
                              },
                              child: const Text(
                                "Clear",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,

                                ),
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  "Back",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0

                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
