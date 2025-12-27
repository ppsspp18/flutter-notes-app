import 'package:flutter/material.dart';
import 'package:frontend/models/notes.dart';
import 'package:frontend/pages/add_new_note.dart';
import 'package:frontend/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // to format date

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title : Text("Home Page", style : TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body : SafeArea(
        child : GridView.builder(
          gridDelegate : SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount : 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            childAspectRatio: 0.95,
          ),
          itemCount: notesProvider.notes.length,
          itemBuilder: (context, index){
            Note currentNote = notesProvider.notes[index];
            String formattedDate = DateFormat("HH:mm, dd/MM/yyyy").format(currentNote.dateadded!);
            return Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  style: BorderStyle.solid
                )
              ),
              child : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 0,
                    child: Text(
                      currentNote.title!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(
                      currentNote.content!,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => AddNewPage(),
                fullscreenDialog:true,
            )
          );
        },
        child : Icon(Icons.add),
      ),
    );
  }
}
