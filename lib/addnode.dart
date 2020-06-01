import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class AddNotes extends StatefulWidget{
  AddNotes({Key key}):super(key:key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes>{
  final GlobalKey<ScaffoldState> addNoteSKey= new GlobalKey<ScaffoldState>();
  DatabaseReference addNoteRef;
  String note='';
  Future<Null> createNote() async {
    addNoteRef = FirebaseDatabase.instance.reference().child('notes');
    print(note);
    addNoteRef.push().set(<String, String>{
      'note':note
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: addNoteSKey,
      appBar: AppBar(
        title: Text('ESOX'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
        children: <Widget>[
          SizedBox(height: 200,),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Add Your Note Here',
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (val){
              setState(() {
                note=val;
              });
            },
          ),
          RaisedButton(
            child: Text('Add Note'),
            onPressed: ()async {
            createNote().then((value) => 
            {addNoteSKey.currentState.showSnackBar(SnackBar(content: Text('Note Added')))}
            );
          },)
        ],
      ),
      )
    );
  }
}
