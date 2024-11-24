import 'package:flutter/material.dart';
import 'package:calculador/desktop.dart';
import 'package:calculador/phone.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: CambioPantallas(),
    );
  }
}


//agregue tableta solo para practicar, pero se puede quitar y bottar su archivo
class CambioPantallas extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 800){
      return const Phone();
     }else {
      return const Desktop();
     }
  }

}

