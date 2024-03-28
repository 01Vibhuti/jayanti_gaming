import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:satta_chat/Screens/group_descr.dart';

class GroupIcon extends StatefulWidget {
    GroupIcon({super.key, required this.image, required this.name, required this.data});
  final String image;
  final String name;
  final String data;


  @override
  State<GroupIcon> createState() => _GroupIconState();
}

class _GroupIconState extends State<GroupIcon> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);

            }, icon: Icon(
            Icons.arrow_back_rounded,color: Colors.amber,
          ),
          ),
          actions: <Widget>[
            IconButton(onPressed: () {

            }, icon: Icon(Icons.more_vert_rounded,color: Colors.amber,))
          ],
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

              Container(alignment: Alignment.topLeft,
                height: 80,
                width: 390,
                color: Colors.grey ,
                child: Column(
                  children: [
                    TextButton(onPressed: (){
                    
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GroupDes(name: widget.name!, image: widget.image!,)));
                    
                    }, child: Text('Add group description',style: TextStyle(
                        fontSize: 20, color: Colors.amber
                    ),),
                    ),

                    Text(widget.data.toString(),
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 18
                    ),)
                    
                  ],
                ),
                
              ),




            ],
          ),
        ),
      ),
    );

  }
}
