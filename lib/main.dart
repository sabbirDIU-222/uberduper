import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uberduper/AllScreens/loginScreen.dart';
import 'package:uberduper/AllScreens/registrationScreen.dart';
import './AllScreens/main_screen.dart';

void main() async
{
  // for binding
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

}


DatabaseReference userReference = FirebaseDatabase.instance.ref().child('users');

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {


    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Texi Khuji . com',
      theme: ThemeData(
        //fontFamily: 'Signatra',
        primaryColor: Colors.blue,

      ),
      initialRoute: logInScreen.screenId,
      routes: {
        RegistrationScreen.screenId: (context) => RegistrationScreen(),
        logInScreen.screenId: (context) => logInScreen(),
        MainScreen.screenId : (context) => MainScreen(),
      },
    );
  }
}
