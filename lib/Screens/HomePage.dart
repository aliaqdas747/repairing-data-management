import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:my_lab/Screens/loginPage.dart';
import 'package:my_lab/utils/alert_dialog.dart';

import '../utils/Custom_Card.dart';
import '../utils/Custom_searchbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _createRecords() {
    showDialog(
      context: context,
      builder: (context) {
        return Custom_Dialog();
      },
    );
  }
  void deleteRecord(String docId) {
    FirebaseFirestore.instance.collection("Lab Records").doc(docId).delete().then((_) {
      print("Document successfully deleted!");
    }).catchError((error) {
      print("Error removing document: $error");
    });
  }
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigoAccent,
        title: const Text('Lab Records', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.blue),
        onPressed: _createRecords,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Custom_searchbar(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Lab Records").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      final labRecords = snapshot.data!.docs;
                      if (labRecords.isEmpty) {
                        return   Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.indigoAccent,
                          child: SizedBox(

                            child: Lottie.asset('assets/images/animation.json', )
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: labRecords.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> labRecord =
                          labRecords[index].data() as Map<String, dynamic>;
                          String docId = labRecords[index].id;

                          int displayIndex = index+1;
                          return CustomCard(

                            phoneModel:labRecord["Model"], customerName: labRecord['Customer Name'], customerPhone: labRecord['Phone no'], issueType: labRecord['Issue'], onDelete: (){deleteRecord(docId);}, amount: labRecord['Amount'], index: '$docId', img: NetworkImage(labRecord['ProfilePic']),);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("No Data"),
                      );
                    }
                  } else {
                    return   Container(
                      color: Colors.indigoAccent,
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                          child: Lottie.asset('assets/images/animation.json')
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
