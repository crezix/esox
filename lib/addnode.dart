import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';


class AddNotes extends StatefulWidget{
  AddNotes({Key key}):super(key:key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes>{
  DatabaseReference addNoteRef;
  String note='';
  Future<Null> createNote() async {
    print(note);
    note!=''?addNoteRef.push().set(<String, String>{
      'note':note
    }).then((_){Scaffold.of(context).showSnackBar(SnackBar(content: Text('Note Added!')));}):
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Empty Note'),));
  }

  @override
  void initState() {
    super.initState();
    addNoteRef = FirebaseDatabase.instance.reference().child('notes');
    addNoteRef.once().then((DataSnapshot snapshot) {
      Map <dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) { 
        print(value);
      });
    });
    //var a = FirebaseDatabase.instance.app.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESOX'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
        children: <Widget>[
          SizedBox(height: 200,),
          TextField(
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
             // print(FirebaseDatabase.instance.c);
            await createNote();
          },)
        ],
      ),
      )
    );
  }
}
