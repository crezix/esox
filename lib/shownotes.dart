import 'package:flutter/material.dart';


class ShowNotes extends StatefulWidget{
  ShowNotes({Key key,this.notes}):super(key:key);
  final List notes;
  


  @override
  _ShowNotesState createState() => _ShowNotesState();
}

class _ShowNotesState extends State<ShowNotes>{
  static List<Widget> noteCards;
  static int selected;

  void setCards(){
    noteCards=[];
    for(int i=0;i<widget.notes.length;i++){
      noteCards.add(
        InkWell(
          onTap: (){
            setState(() {
              selected=i;
            });
            setCards();
            print(selected);
          },
          child: Card(
          color: selected==i?Colors.yellowAccent:null,
          child: ListTile(
            title: Text('Note :'+(i+1).toString()),
            subtitle: Text(widget.notes[i]['note']),
          ),
          ),
        )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setCards();
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
          children: noteCards,
        ),
      ),
    );
  }
}