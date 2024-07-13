import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_lab/Screens/loginPage.dart';
import 'package:my_lab/utils/Custom_btn.dart';
import '../utils/CustomTextField.dart';

class SignIN extends StatefulWidget {
  const SignIN({super.key});

  @override
  State<SignIN> createState() => _SignINState();
}

class _SignINState extends State<SignIN> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  Future<void> createUser() async {
    String email = emailController.text.trim();
    String password = passController.text.trim();
    String confirmPassword = cPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    } else if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords don't match")),
      );
    } else {
      try {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("loading...")));
         await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        emailController.clear();
        cPasswordController.clear();
        passController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User is Created Successfully')),

        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The password provided is too weak.')),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The account already exists for that email.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/signIn.png', height: 100),
                    Text(
                      'Create Your account',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 30),
                            //  TextField(controller: emailController,),
                            Custom_field(label: 'Email', Icon1: Icon(Icons.email), isVisible: false, controller: emailController),
                            SizedBox(height: 15),
                            //  TextField(controller: passController,),
                             Custom_field(label: 'Password', Icon1: Icon(Icons.password), isVisible: true, controller: passController),
                            SizedBox(height: 15),
                            //  TextField(controller: cPasswordController,),
                           Custom_field(label: 'Confirm Password', Icon1: Icon(Icons.password), isVisible: true, controller: cPasswordController),
                            SizedBox(height: 30),
                            InkWell(
                              onTap: createUser,
                              child: Custom_btn(title: 'Sign In'),
                            ),
                          ],
                        ),
                        SizedBox(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black54),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                              },
                              child: Text(
                                'Login',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
