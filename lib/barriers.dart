
import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  
  final size;
 Barrier({required this.size})  ;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xfff1bd30),
        border: Border.all(width: 5 , color: Colors.brown),
        borderRadius: BorderRadius.circular(14)
      ),
    );
  }
}
