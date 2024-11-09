import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: NotesHome(),
  ));
}

class NotesHome extends StatefulWidget {
  const NotesHome({super.key});

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _notesList = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void deleteNote(int index) {
    setState(() {
      _notesList.removeAt(index);
    });
  }

  Widget singleNote(int index) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        shadowColor: Colors.grey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    _notesList[index]),
              ),
              ElevatedButton(
                  onPressed: () => deleteNote(index),
                  child: Icon(Icons.delete_rounded)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note-it'),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _notesList.length,
                itemBuilder: (context, index) {
                  return singleNote(index);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter a note',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _notesList.add(_controller.text);
            _controller.clear();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
