import 'package:flutter/material.dart';

import 'group_descr.dart';

class ProfileUi extends StatefulWidget {
  final String image;
  final String name;
  final String data;
  const ProfileUi({Key? key, required this.image, required this.name, required this.data}) : super(key: key);

  @override
  State<ProfileUi> createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage("${widget.image.toString()}"),
            ),
            SizedBox(height: 5,),
            Text(widget.name.toString(),style: TextStyle(
                color: Colors.amber, fontSize: 25
            ),),
            SizedBox(height: 10,),






          ],
        ),
      ),
    );
  }
}
