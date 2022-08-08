import List "mo:base/List"; //To use List's methods we have to import it.
import Debug "mo:base/Debug";



actor DKeeper {

  //Creating a new data type of type Note
  public type Note = {
    title: Text;
    content: Text;
  };

  //Creating a variable of type List. The List is going to contain Note type.
  stable var notes: List.List<Note> = List.nil<Note>();

/*----------------------------------------Create Data----------------------------------------*/

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
  };

/*----------------------------------------Delete Data----------------------------------------*/
  //Creating a public function that will delete a note and it will target it through an id who's of type natural.
  public func removeNote(id: Nat) {
    //Using the take method to return the n first items of the notes list
    //Creating a List that will store the notes left to the indexed note to be deleted
    var remainingNotesL : List.List<Note> = List.nil<Note>();
    //Creating a List that will store the notes right to the indexed note to be deleted
    var remainingNotesR : List.List<Note> = List.nil<Note>();
    //Storing the new left list
    remainingNotesL := List.take(notes, id);
    //Storing the new Right List
    remainingNotesR := List.drop(notes, id + 1);
    //Merging the two previous Lists to form the new notes List
    notes := List.append(remainingNotesL, remainingNotesR); 
    Debug.print(debug_show(notes));
  };

}