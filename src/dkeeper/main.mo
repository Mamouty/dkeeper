import List "mo:base/List"; //To use List's methods we have to import it.
import Debug "mo:base/Debug";

/*----------------------------------------Create Data----------------------------------------*/

actor DKeeper {
  //Creating a new data type of type Note
  public type Note = {
    title: Text;
    content: Text;
  };

  //Creating a variable of type List. The List is going to contain Note type.
  var notes: List.List<Note> = List.nil<Note>();

  //Creating a public function that is going to send over some titleText and contentText from the JavaScript side when the user enters them.
  public func createNote(titleText: Text, contentText: Text) {

      let newNote: Note = {
        title = titleText;
        content = contentText;
      };  
      //Assigning to notes the newly created list of notes with the function List.push(item, list.)
      notes := List.push(newNote, notes);
      Debug.print(debug_show(notes));
  };

/*----------------------------------------Read Data----------------------------------------*/

  //Creating a public query function that'll return asynchronously an array of notes
  public query func readNotes(): async [Note] {
    //Converting our list notes to an array
    return List.toArray(notes);
  }

};