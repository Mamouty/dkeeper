import React, { useEffect, useState } from "react";
import Header from "./Header";
import Footer from "./Footer";
import Note from "./Note";
import CreateArea from "./CreateArea";
//Importing anything from the dkeeper canister
import { dkeeper} from "../../../declarations/dkeeper";

function App() {
  const [notes, setNotes] = useState([]);

  function addNote(newNote) {
    setNotes(prevNotes => {
      //Calling the function createNote from the dkeeper canister before returning
      dkeeper.createNote(newNote.title, newNote.content);
      //Returning the newNote at the beginning and the prevNots after it.
      return [newNote, ...prevNotes];
    });
  }

  //Adding the Effect Hook to trigger a function when the App component gets rendered.
  useEffect(() => {
    console.log("useEffect triggered");
    //Calling the fetchData function
    fetchData();
    //To ensure that useEffect is run only once we add an empty array as a second parameter.
  }, []);

  //Creating another function that is asynchronous since useEffect can't be turned into an asynchronous function itself.
  async function fetchData() {
    //Storing the returned array in a local constant
    const notesArray = await dkeeper.readNotes();
    //Once the array is returned we use it to update the notes with setNotes().
    setNotes(notesArray);
  };


  function deleteNote(id) {
    setNotes(prevNotes => {
      dkeeper.removeNote(id);
      return prevNotes.filter((noteItem, index) => {
        return index !== id;
      });
    });
  }

  return (
    <div>
      <Header />
      <CreateArea onAdd={addNote} />
      {notes.map((noteItem, index) => {
        return (
          <Note
            key={index}
            id={index}
            title={noteItem.title}
            content={noteItem.content}
            onDelete={deleteNote}
          />
        );
      })}
      <Footer />
    </div>
  );
}

export default App;
