import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notekeeper/createpin.dart';
import 'package:notekeeper/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notekeeper/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

TextEditingController pin = TextEditingController();

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  var emmail;
  var password;
  var passwordVisibility;
  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Image(
            image: AssetImage('asset/mycontainerimg.png'),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 50,
              width: double.infinity,
              child: Center(
                child: Material(
                  child: TextFormField(
                    onChanged: (value) {
                      emmail = value;
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
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 50,
              width: double.infinity,
              child: Center(
                child: Material(
                  child: TextFormField(
                    onChanged: (value) {
                      password = value;
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
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              try {
                final user = await _auth.signInWithEmailAndPassword(
                    email: emmail, password: password);
                if (user != null) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                }
              } catch (e) {
                print(e);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text('Login',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Fascinate',
                          color: Colors.white)),
                ),
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
                'Don\'t have account?',
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreatePin()));
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
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
    ));
  }
}
