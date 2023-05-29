
import 'package:flutter/material.dart';

class Barriertwo extends StatelessWidget {
  
  final size;
 Barriertwo({required this.size})  ;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xff9b1414),
        border: Border.all(width: 5 , color: Colors.brown),
        borderRadius: BorderRadius.circular(14)
      ),
    );
  }
}
