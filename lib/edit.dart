import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  DocumentSnapshot docToEdit;
  EditPage({this.docToEdit});
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit.get('title'));
    body = TextEditingController(text: widget.docToEdit.get('body'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Write Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              widget.docToEdit.reference.update({
                'title': title.text,
                'body': body.text,
              }).whenComplete(() => Navigator.pop(context));
              Navigator.pop(context);

              //   ref.add(
            },
          ),
          IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                widget.docToEdit.reference
                    .delete()
                    .whenComplete(() => Navigator.pop(context));
                Navigator.pop(context);

                //   ref.add(
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: null,
                  minLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                        fontFamily: 'Lobster',
                        fontSize: 30,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 600,
                width: double.infinity,
                child: TextFormField(
                  controller: body,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  minLines: 25,
                  maxLines: 1000,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.deepPurple,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
