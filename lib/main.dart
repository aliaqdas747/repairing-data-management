
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_lab/Screens/HomePage.dart';
import 'package:my_lab/Screens/SignUp.dart';
import 'package:my_lab/Screens/loginPage.dart';
import 'package:my_lab/firebase_options.dart';




void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),
      home :(FirebaseAuth.instance.currentUser != null) ?MyHomePage():LoginPage()
    );
  }
}

