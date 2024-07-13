import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_lab/Screens/loginPage.dart';

import '../utils/Custom_Card.dart';
import '../utils/ListTile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void logout()async{
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            logout();
          }, icon: Icon(Icons.logout,color: Colors.white,))
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade700,
        title: Text('Lab Records',style: TextStyle(color: Colors.white),),
        centerTitle: true,

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade800,
        child: const Icon(Icons.add,color: Colors.white,),
        onPressed: (){},
      ),
      body: ListView(
        children: [
          CustomCard(   phoneModel: 'phone 12', customerName: 'Ali Aqdas', customerPhone: '093324230944', issueType: 'wqeweqweqwe', onDelete: () {  },),
          CustomCard(   phoneModel: 'phone 12', customerName: 'Ali Aqdas', customerPhone: '093324230944', issueType: 'wqeweqweqwe', onDelete: () {  },),
          CustomCard(   phoneModel: 'phone 12', customerName: 'Ali Aqdas', customerPhone: '093324230944', issueType: 'wqeweqweqwe', onDelete: () {  },),
          CustomCard(   phoneModel: 'phone 12', customerName: 'Ali Aqdas', customerPhone: '093324230944', issueType: 'wqeweqweqwe', onDelete: () {  },),
          CustomCard(   phoneModel: 'phone 12', customerName: 'Ali Aqdas', customerPhone: '093324230944', issueType: 'wqeweqweqwe', onDelete: () {  },),
        ],
      ),
    );
  }
}
