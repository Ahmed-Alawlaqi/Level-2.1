import 'dart:io';

// Define a Note class to represent individual notes
class Note {
  late String title;
  late String content;

  // Constructor
  Note({
    required this.title,
    required this.content,
  });
}

// Define a NotesManager class to manage notes
class NotesManager {
  List<Note> notes = [];

  // Method to create a new note
  void createNote() {
    print('\nEnter note details:');
    stdout.write('Title: ');
    var title = stdin.readLineSync()!;
    stdout.write('Content: ');
    var content = stdin.readLineSync()!;
    
    var newNote = Note(
      title: title,
      content: content,
    );
    
    notes.add(newNote);
    print('\nNote created successfully!');
  }

  // Method to edit an existing note
  void editNote() {
    if (notes.isEmpty) {
      print('\nNo notes available to edit.');
      return;
    }

    stdout.write('\nEnter note title to edit: ');
    var titleToEdit = stdin.readLineSync()!;
    
    var foundNote = notes.firstWhere(
      (note) => note.title == titleToEdit,
      orElse: () => Note(
        title: '',
        content: '',
      ),
    );

    if (foundNote.title.isEmpty) {
      print('Note with title "$titleToEdit" not found.');
      return;
    }

    stdout.write('Enter new content: ');
    var newContent = stdin.readLineSync()!;
    foundNote.content = newContent;
    print('\nNote edited successfully!');
  }

  // Method to delete a note
  void deleteNote() {
    if (notes.isEmpty) {
      print('\nNo notes available to delete.');
      return;
    }

    stdout.write('\nEnter note title to delete: ');
    var titleToDelete = stdin.readLineSync()!;
    notes.removeWhere((note) => note.title == titleToDelete);
    print('\nNote deleted successfully!');
  }

  // Method to search for a note by title or content
  void searchNote() {
    if (notes.isEmpty) {
      print('\nNo notes available to search.');
      return;
    }

    stdout.write('\nEnter search term: ');
    var searchTerm = stdin.readLineSync()!.toLowerCase();
    var searchResults = notes.where((note) =>
        note.title.toLowerCase().contains(searchTerm) ||
        note.content.toLowerCase().contains(searchTerm));

    if (searchResults.isEmpty) {
      print('No matching notes found.');
    } else {
      print('\nSearch results:');
      searchResults.forEach((note) {
        print('Title: ${note.title}');
        print('Content: ${note.content}');
        print('----------------------');
      });
    }
  }
}

// Main function to run the app
void main() {
  var notesManager = NotesManager();
  var running = true;

  while (running) {
    print('\nNote Taking App');
    print('1. Create a note');
    print('2. Edit a note');
    print('3. Delete a note');
    print('4. Search for a note');
    print('5. Exit');
    
    print('\n---------------------------------'); // Separator
    
    stdout.write('\nSelect an option: ');

    var option = stdin.readLineSync();

    switch (option) {
      case '1':
        notesManager.createNote();
        break;
      case '2':
        notesManager.editNote();
        break;
      case '3':
        notesManager.deleteNote();
        break;
      case '4':
        notesManager.searchNote();
        break;
      case '5':
        running = false;
        break;
      default:
        print('\nInvalid option. Please try again.');
        break;
    }
    
    print('---------------------------------'); // Separator
  }

  print('\nExiting Note Taking App...');
}
