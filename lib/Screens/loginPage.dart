import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_lab/Screens/HomePage.dart';
import 'package:my_lab/Screens/SignUp.dart';
import 'package:my_lab/utils/Custom_btn.dart';

import '../utils/CustomTextField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController login_email = TextEditingController();
  TextEditingController login_password = TextEditingController();

 void Login()async{
   String email = login_email.text.trim();
   String password = login_password.text.trim();

   if(email == "" || password == ""){
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Please fill all fields'))
     );
   }else{
     try{
       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
       if(userCredential.user!= null){
         Navigator.popUntil(context, (route) => route.isFirst);
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(  "Welcome back! You have logged in successfully. ")));

       }
     }on FirebaseAuthException catch(ex){
       print(ex.code.toString());
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
            flex: 2,
            child: Container(
              child: Center(
                child:   Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/login.png',height: 150,),
                    Text('Please Login to continue',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),),

                  ],
                )
                //
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(80))
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child:SingleChildScrollView(
                    child: Column(
                    
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                   //         Text('Login to manage repair records and shop data.',style: Theme.of(context).textTheme.bodyLarge),
                    
                            SizedBox(height: 30,),
                           Custom_field(label: 'Email', Icon1: Icon(Icons.email), isVisible: false, controller: login_email,),
                            SizedBox(height: 20,),
                          Custom_field(label: 'Password',Icon1: Icon(Icons.password), isVisible: true, controller: login_password,),
                            SizedBox(height: 30,),
                            InkWell(
                                onTap: (){
                                  Login();
                                },
                                child: Custom_btn(title: 'LOGIN',))
                          ],
                        ),
                        SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Create a new account ',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black54)),
                    
                    
                            InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignIN()));
                                },
                                child: Text('Sign In',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.blue.shade900,fontWeight: FontWeight.bold))),
                          ],
                        ),
                    
                      ],
                    ),
                  ) ,
                ),
              ),
              
             

            ),
          )
        ],
      ),
    );
  }
}
