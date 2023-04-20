import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uberduper/AllScreens/registrationScreen.dart';
import 'package:uberduper/AllWidget/progressDialoge.dart';

import '../main.dart';
import 'main_screen.dart';

class logInScreen extends StatelessWidget {
  static const String screenId = 'logIn';
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 35.0,
              ),
              Image(
                width: 390,
                height: 200,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                image: AssetImage('images/logo.png'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'log In as a Rider',
                style: TextStyle(
                  fontFamily: 'BoltRegular',
                  fontWeight: FontWeight.bold,
                  fontSize: 23.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.0,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // email text field
                    TextField(
                      controller: emailText,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                          labelText: 'email',
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          )),
                    ),

                    SizedBox(
                      height: 2.0,
                    ),
                    // password
                    TextField(
                      controller: passwordText,
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                          labelText: 'password',
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (!emailText.text.contains('@')) {
                            makeAToastMessage('enter valid email', context);
                          } else if (passwordText.text.isEmpty) {
                            makeAToastMessage('enter password', context);
                          } else {
                            loginAuthenticUser(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          padding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Center(
                            child: Text(
                              'LogIn',
                              style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontSize: 22.0,
                                  fontFamily: 'BoltSemibold'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RegistrationScreen.screenId, (route) => false);
                  },
                  child: Text('do not have an account?    Regester here')),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  loginAuthenticUser(BuildContext context) async {
    // if user is authentic then a progerss dialog show
    showDialog(context: context,
      barrierDismissible: false,
      builder: (context) {
     return ProgressDialog(messaage: 'logging in, Please hold',);
    },);

    // data fetch from firebase
    final UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(
            email: emailText.text.trim(), password: passwordText.text.trim())
        .catchError((error) {
          Navigator.pop(context);
      print('error:  $error');
    },
            test: (error) =>
                makeAToastMessage('error ' + error.toString(), context));

    final User user = userCredential.user!;

    if (user != null) {
      userReference
          .child(user.uid)
          .once()
          .then((snapshot) async {
                if (snapshot != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainScreen.screenId, (route) => false);
                  makeAToastMessage('you are In.', context);
                } else {
                  Navigator.pop(context);
                  _firebaseAuth.signOut();
                  makeAToastMessage(
                      'email or pass invalid! please register first', context);
                }
              });
    } else {
      Navigator.pop(context);
      makeAToastMessage('registration is not complete! try again', context);
    }
  }
}
