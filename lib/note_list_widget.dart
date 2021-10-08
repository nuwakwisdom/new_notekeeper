import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notekeeper/edit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class NotListWidget extends StatefulWidget {
  const NotListWidget({Key key}) : super(key: key);

  @override
  _NotListWidgetState createState() => _NotListWidgetState();
}

class _NotListWidgetState extends State<NotListWidget> {
  final _auth = FirebaseAuth.instance;

  FirebaseAuth loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    print(loggedInUser.currentUser.email);
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = _auth;
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController searchController = TextEditingController();
  final ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, _index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPage(
                                  docToEdit: snapshots.data.docs[_index],
                                )));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          snapshots.data.docs[_index].get('title'),
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: Colors.white,
                      )
                    ],
                  ),
                );
              },
              itemCount: snapshots.hasData ? snapshots.data.docs.length : 0,
            ),
          );
        });
  }
}
