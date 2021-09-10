import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              right: 160,
            ),
            child: Text(
              'Say Hello',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              right: 260,
            ),
            child: Text(
              'Name',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 40,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Charles Archibong',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 25,
              right: 240,
            ),
            child: Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 40,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'hjhfkkkdjjdldldoojdkkd',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Container(child: ListTile()),
        ],
      ),
    );
  }
}
