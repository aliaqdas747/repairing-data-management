import 'package:flutter/material.dart';

class Custom_btn extends StatelessWidget {
  final String title;



  const Custom_btn({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
     width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text(title,style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),)),
      ),
    );
  }
}
