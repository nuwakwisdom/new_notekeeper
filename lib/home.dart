import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/edit.dart';
import 'package:notekeeper/note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notekeeper/note_list_widget.dart';
import 'package:notekeeper/users.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Home extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  bool showContainer = false;

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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Notes',
          style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: DataSearch());
            },
            child: Container(
              child: Icon(Icons.search_outlined),
              color: Colors.white12,
              height: 60,
              width: 60,
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white12,
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
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
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
                                          docToEdit:
                                              snapshots.data.docs[_index],
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
                      itemCount:
                          snapshots.hasData ? snapshots.data.docs.length : 0,
                    ),
                  );
                })
          ])),
    );
  }
}

class DataSearch extends SearchDelegate {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');
  final seartData = [NotListWidget()];

  final recentSearch = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return NotListWidget();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentSearch : seartData;

    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 13, left: 20),
          child: Text(
            'Search notes',
            style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 23,
                fontWeight: FontWeight.w400,
                color: Color(0xff666666)),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: suggestionList.length,
                itemBuilder: (context, index) {
                  return NotListWidget();
                }))
      ]),
    );
  }
}
