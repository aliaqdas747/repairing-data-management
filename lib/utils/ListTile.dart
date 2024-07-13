import 'package:flutter/material.dart';

class Custom_ListTile extends StatefulWidget {
  const Custom_ListTile({super.key});

  @override
  State<Custom_ListTile> createState() => _Custom_ListTileState();
}

class _Custom_ListTileState extends State<Custom_ListTile> {
  @override
  Widget build(BuildContext context) {
    return  Container(

      decoration: BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: BorderRadius.circular(20)
      ),
      width: double.infinity,

      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mobile Model: I phone 15',style: TextStyle(color: Colors.white,fontSize: 20),),
            Text('Customer Name: I phone 15',style: TextStyle(color: Colors.white,fontSize: 20),),
            Text('Phone Number: I phone 15',style: TextStyle(color: Colors.white,fontSize: 20),),
            Text('Type Issue: I phone 15',style:TextStyle(color: Colors.white,fontSize: 20),),
            Text('Amount: I phone 15',style: TextStyle(color: Colors.white,fontSize: 20),),
            Row(children: [
              Checkbox(value: true, onChanged: (context)=>{}),
              Text('Repaired ',style: TextStyle(color: Colors.white,fontSize: 20),),
            ],),
            Row(children: [
              Checkbox(value: false, onChanged: (context)=>{}),
              Text('In Process ',style: TextStyle(color: Colors.white,fontSize: 20),),
            ],),
            Row(children: [
              Checkbox(value: false, onChanged: (context)=>{}),
              Text('Panding ',style: TextStyle(color: Colors.white,fontSize: 20),),
            ],)
          ],
        ),
      ),
    );
  }
}
