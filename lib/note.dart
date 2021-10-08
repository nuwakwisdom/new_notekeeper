import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notekeeper/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Note extends StatefulWidget {
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  File _image;
  final _auth = FirebaseAuth.instance;
  FirebaseAuth loggedInUser;

  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');

  Future getImage() async {
    final images = await ImagePicker().pickImage(source: ImageSource.camera);
    if (images == null) return;
    final imageDisplay = File(images.path);
    setState(() => this._image = imageDisplay);
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref(ref.path).child('uploads/$fileName');

    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
    if (taskSnapshot.state == TaskState.success) {
      final String downloadurl = await taskSnapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('image')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('notes')
          .add({'url': downloadurl});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Write Notes',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            height: 40,
            width: 60,
            color: Colors.white12,
            child: IconButton(
              icon: Icon(Icons.save, color: Colors.white),
              onPressed: () {
                uploadImageToFirebase(context);

                ref.add({
                  'id': _auth.currentUser.uid,
                  'user': _auth.currentUser.email,
                  'title': title.text,
                  'body': body.text,
                }).whenComplete(() => Navigator.pop(context));
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    controller: title,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: null,
                    minLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 30,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.white)),
                height: 600,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: _image != null
                              ? Image.file(
                                  _image,
                                  height: 200,
                                  width: 500,
                                )
                              : Container(),
                        ),
                        TextFormField(
                          cursorColor: Colors.white,
                          controller: body,
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontFamily: 'Pacifico',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          minLines: 25,
                          maxLines: 1000,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(),
                        ),
                      ],
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
