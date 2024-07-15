import 'package:flutter/material.dart';

class Custom_searchbar extends StatefulWidget {
  const Custom_searchbar({super.key});

  @override
  State<Custom_searchbar> createState() => _Custom_searchbarState();
}

class _Custom_searchbarState extends State<Custom_searchbar> {
  @override
  Widget build(BuildContext context) {
    return    Container(
      margin:const EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 20),
      height: 50,width:double.infinity,
      child: SizedBox(
        width: 100,
        child:   TextField(style: TextStyle(color: Colors.indigoAccent),

          decoration: InputDecoration(

            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search,color :Colors.indigoAccent),),
            label: Text("Search here...", style: TextStyle(color:Colors.indigoAccent,fontSize: 25),),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigoAccent, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigoAccent, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
