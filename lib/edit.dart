import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/home.dart';

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
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.black,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Are you sure you want delete this note',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Pacifico',
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        widget.docToEdit.reference
                                            .delete()
                                            .whenComplete(() =>
                                                Navigator.pushReplacement<void,
                                                    void>(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        Home(),
                                                  ),
                                                ));
                                        Navigator.pushReplacement<void, void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                Home(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'Pacifico',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontFamily: 'Pacifico',
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          height: 200,
                          color: Colors.white12,
                        ),
                      );
                    });

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
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    controller: title,
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.white,
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
                  child: TextFormField(
                    controller: body,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    minLines: 25,
                    maxLines: 1000,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(),
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
