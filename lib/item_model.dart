class Note {
  int? id;
  String title;
  String description;

  Note({
    this.id,
    required this.title,
    required this.description,
  });

// Convert a Dog into a Map. The keys must correspond to the names of the
// columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'title': title,
      'description': description,
    };
  }

//use CTRL+ALT+L TO FOR CODE FORMATTING
  //factory constructor that take Map and convert it to Object
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }
}
