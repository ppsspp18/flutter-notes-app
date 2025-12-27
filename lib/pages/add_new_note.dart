import 'package:flutter/material.dart';
import 'package:frontend/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/notes.dart';
import 'package:uuid/uuid.dart';

class AddNewPage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewPage({super.key,required this.isUpdate, this.note});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void addNewNote(){
     final uuid = Uuid();
     Note newNote = Note(
       id : uuid.v1(),
       userid: "psp61",
       title: titleController.text,
       content: contentController.text,
       dateadded: DateTime.now()
     );
     Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
     Navigator.pop(context);
  }

  void updateNote(){
    Note newNote = Note(
        id : widget.note!.id,
        userid: widget.note!.userid,
        title: titleController.text,
        content: contentController.text,
        dateadded: DateTime.now()
    );
    Provider.of<NotesProvider>(context, listen: false).updateNote(newNote);
    Navigator.pop(context);
  }

  @override
  void initState(){
    super.initState();
    if(widget.isUpdate){
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  FocusNode noteFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions : [
          IconButton(
            onPressed: (){
              (widget.isUpdate) ? updateNote() : addNewNote();
            },
            icon : Icon(Icons.check)
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body : SafeArea(
        child : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                onSubmitted: (val){
                  if(val != ""){
                    noteFocus.requestFocus();
                  }
                },
                style: TextStyle(
                   fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                autofocus: (widget.isUpdate) ? false : true,
                decoration : InputDecoration(
                  hintText: "Title",
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none
                )
              ),
              Expanded(
                child : TextField(
                  controller: contentController,
                  focusNode: noteFocus,
                  maxLines:  null,
                  decoration: InputDecoration(
                    hintText: "note",
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none
                  )
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
