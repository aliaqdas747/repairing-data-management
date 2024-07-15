import 'dart:ffi';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_lab/utils/CustomTextField.dart';
import 'package:uuid/uuid.dart';

class Custom_Dialog extends StatefulWidget {
  const Custom_Dialog({super.key});

  @override
  State<Custom_Dialog> createState() => _Custom_Dialog();
}

class _Custom_Dialog extends State<Custom_Dialog> {
  final TextEditingController mobile_Controller = TextEditingController();
  final TextEditingController CustomerName_controller = TextEditingController();
  final TextEditingController Phone_no_Controller = TextEditingController();
  final TextEditingController Issue_controller = TextEditingController();
  final TextEditingController Amount = TextEditingController();
  File? profilePic;


  void SaveData() async {
    String model = mobile_Controller.text.trim();
    String name = CustomerName_controller.text.trim();
    String phone = Phone_no_Controller.text.trim();
    String issue = Issue_controller.text.trim();
    String amount = Amount.text.trim();

    if (model.isEmpty || name.isEmpty || phone.isEmpty || issue.isEmpty || amount.isEmpty || profilePic  ==null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));

    } else {

      try {
        UploadTask uploadTask =FirebaseStorage.instance.ref().child("profilePictures").child(Uuid().v1()).putFile(profilePic!);
        TaskSnapshot taskSnapshot = await  uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        Map<String, dynamic> lab_Records = {
          'ProfilePic':downloadUrl,
          'Model': model,
          'Customer Name': name,
          'Phone no': phone,
          'Issue': issue,
          'Amount': amount
        };
        await FirebaseFirestore.instance.collection('Lab Records').add(lab_Records);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data Saved Successfully")));
        mobile_Controller.clear();
        CustomerName_controller.clear();
        Phone_no_Controller.clear();
        Issue_controller.clear();
        profilePic = null;
        Amount.clear();
      } catch (e) {
        print('$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 300,),
            CupertinoButton(
                onPressed: ()async{
              XFile? selectedImage =await ImagePicker().pickImage(source:  ImageSource.gallery );

            if(selectedImage != null){
              File convertedFile = File(selectedImage.path);
              print('Selected Image');
              setState(() {
                profilePic =convertedFile;
              });
            }else{
              print(' No Selected Image');
            }
                },
              padding: EdgeInsets.zero,
              child: CircleAvatar(
                backgroundImage: (profilePic != null) ? FileImage
                  (profilePic!) :null,
                radius: 50,
              ),
            ),
            const SizedBox(height: 10,),
            Custom_field(
              label: 'Mobile Model',
              Icon1: Icon(Icons.mobile_friendly),
              isVisible: false,
              controller: mobile_Controller,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10,),
            Custom_field(
              label: 'Customer Name',
              Icon1: Icon(Icons.person),
              isVisible: false,
              controller: CustomerName_controller,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10,),
            Custom_field(
              label: 'Phone NO#: ',
              Icon1: Icon(Icons.phone),
              isVisible: false,
              controller: Phone_no_Controller,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10,),
            Custom_field(
              label: 'Type Issue',
              Icon1: Icon(Icons.report_problem_outlined),
              isVisible: false,
              controller: Issue_controller,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10,),
            Custom_field(
              label: 'Amount',
              Icon1: Icon(Icons.money),
              isVisible: false,
              controller: Amount,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
          ),
          onPressed: () {
            SaveData();
            Navigator.of(context).pop();
          },
          child: const Text('Save', style: TextStyle(color: Colors.white),),
        )
      ],
    );
  }
}