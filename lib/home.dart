import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/edit.dart';
import 'package:notekeeper/note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notekeeper/users.dart';

class Home extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  final ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Keep Note',
        ),
        centerTitle: true,
        actions: [],
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Note(),
                  ));
            },
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: 'Search note',
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .doc(_auth.currentUser.uid)
                        .collection('notes')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                      return ListView.builder(
                        itemBuilder: (context, _index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditPage(
                                              docToEdit:
                                                  snapshots.data.docs[_index],
                                            )));
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    top: 30,
                                    right: 20,
                                  ),
                                  child: Text(
                                    snapshots.data.docs[_index][''],
                                    style: TextStyle(
                                      fontFamily: 'Lobster',
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                height: 80,
                                width: 500,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 2.5,
                                    )),
                              ),
                            ),
                          );
                        },
                        itemCount:
                            snapshots.hasData ? snapshots.data.docs.length : 0,
                      );
                    }))
          ])),
    );
  }
}
