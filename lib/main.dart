import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_app/itemform.dart';
import 'mycontroller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

//set app icon for my app
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UIController controller = Get.put(UIController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sufian`s Note app"),
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: Get.context!,
              builder: (context) => AlertDialog(
                title: Text("Setting Pressed"),
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Center(
                      child: Icon(Icons.cancel),
                    ),
                    alignment: Alignment.center,
                    iconSize: 50.0,
                  ),
                ],
              ),
            );
          },
          icon: Icon(Icons.settings),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          )
        ],
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.NoteItems.length,
          itemBuilder: (context, index) {
            final note = controller.NoteItems[index];
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                color: Colors.white10,
                child: Ink(
                  // color: Colors.lightGreen,
                  child: ListTile(
                    // tileColor: Colors.blueAccent,
                    // hoverColor: Colors.green,
                    leading: Icon(Icons.person_2_sharp),
                    onTap: () {
                      UserForm userForm = UserForm(
                        AppBarTitile: "update",
                        note: note,
                      );
                      Get.to(() => userForm, arguments: note);
                    },
                    title: Text(note.title.toString(),
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text(note.description.toString(),
                        style: TextStyle(color: Colors.blueAccent)),
                    trailing: SizedBox(
                      width: 100,
                      height: 100,
                      child: Row(
                        children: [
                          IconButton(
                            color: Colors.green,
                            icon: const Icon(
                              Icons.edit,
                              // color: Colors.blue,
                              size: 30.0,
                            ),
                            onPressed: () {
                              UserForm userForm =
                                  UserForm(AppBarTitile: "update", note: note);
                              // controller.updateNote(note);
                              Get.to(() => userForm, arguments: note);

                              // debugPrint("edit pressed");
                            },
                          ),
                          IconButton(
                            onPressed: () async {
                              int deletedRow =
                                  await controller.deleteNote(note.id as int);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.green,
        backgroundColor: Colors.blue,
        onPressed: () {
          Get.changeTheme(
              Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
          // Get.to(() => ItemDetailsScreen());
          Get.to(
            () => UserForm(
              AppBarTitile: "Add Item",
            ),
          );
          // Get.back();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
