import 'package:flutter/material.dart';

import 'Screens/chatting_screen.dart';
import 'Screens/columntest.dart';
import 'Screens/mian_page.dart';

void main(){

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "satta chat app",
      //home: TextHistory(),
       home: MainPage(image: '', name: '', data: '',),
    );
  }
}
