import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notekeeper/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notekeeper/login.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text('Sign Up',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              height: 50,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Center(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        name = value;
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Pacifico',
                        decoration: TextDecoration.none,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              height: 50,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFormField(
                    onChanged: (value) {
                      password1 = value;
                    },
                    obscureText: !passwordVisibility,
                    style: TextStyle(
                      fontFamily: 'Pacifico',
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
                            fontFamily: 'Pacifico',
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                        border: InputBorder.none),
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
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => Home(),
                      ),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text('Sign Up',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                          color: Colors.white)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Go back to',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                    decoration: TextDecoration.none,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        decoration: TextDecoration.none,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
