import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notekeeper/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notekeeper/users.dart';

class CreatePin extends StatefulWidget {
  @override
  _CreatePinState createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  final _auth = FirebaseAuth.instance;
  var passwordVisibility;
  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  var name;
  var password1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Fascinate',
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Center(
                child: TextFormField(
                  onChanged: (value) {
                    name = value;
                  },
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
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
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Center(
                child: TextFormField(
                  onChanged: (value) {
                    password1 = value;
                  },
                  obscureText: !passwordVisibility,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        },
                        icon: !passwordVisibility
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
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
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: name, password: password1);
                  if (newUser != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text('Sign Up',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Fascinate',
                          color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
