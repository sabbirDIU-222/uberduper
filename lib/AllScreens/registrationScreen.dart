import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uberduper/AllScreens/loginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uberduper/AllScreens/main_screen.dart';
import 'package:uberduper/main.dart';

import '../AllWidget/progressDialoge.dart';

class RegistrationScreen extends StatelessWidget {
  // for routing
  static const String screenId = 'register';

  TextEditingController nameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController phoneText = TextEditingController();
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
                height: 20.0,
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
                'Register as a Rider',
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
                    // name
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: nameText,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                          labelText: 'name',
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                          )),
                    ),
                    // email text field
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailText,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.start,
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
                      controller: phoneText,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                          labelText: 'phone',
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
                      textAlign: TextAlign.start,
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
                          if (nameText.text.length < 3) {
                            makeAToastMessage(
                                'name at least 3 character', context);
                          } else if (!emailText.text.contains('@')) {
                            makeAToastMessage('enter valid email', context);
                          } else if (phoneText.text.isEmpty) {
                            makeAToastMessage(
                                'name at least 3 character', context);
                          } else if (passwordText.text.length < 6) {
                            makeAToastMessage(
                                'password must be 6 character', context);
                          } else {
                            registerNewUser(context);
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
                              'Create Account',
                              style: TextStyle(
                                  letterSpacing: 1.0,
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
                        context, logInScreen.screenId, (route) => false);
                  },
                  child: Text('do not have an account?     LogIn here')),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {

    // if user is authentic then a progerss dialog show
    showDialog(context: context,
      barrierDismissible: false,
      builder: (context) {
        return ProgressDialog(messaage: 'Registration in process, Please hold',);
      },);

    final UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailText.text, password: passwordText.text)
        .catchError((error) {
          Navigator.pop(context);
      print('error:  $error');
    },
            test: (error) =>
                makeAToastMessage('error ' + error.toString(), context));

    final User user = userCredential.user!;
    if (user != null) {
      // save data to the database

      Map userDataMap = {
        'name': nameText.text,
        'email': emailText.text,
        'phone': phoneText.text,
      };

      userReference.child(user.uid).set(userDataMap);
      makeAToastMessage('congress your registration is completed', context);
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.screenId, (route) => false);

    } else {
      Navigator.pop(context);
      makeAToastMessage('registration is not complete! try again', context);
    }
  }
}

makeAToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
  Toast.LENGTH_SHORT;
}
