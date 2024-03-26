import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:satta_chat/Screens/chatting_screen.dart';

class NameChange extends StatefulWidget {
  const NameChange({Key? key}) : super(key: key);

  @override
  State<NameChange> createState() => _NameChangeState();
}

class _NameChangeState extends State<NameChange> {
  final TextEditingController _nameFirst = TextEditingController();
  final TextEditingController _nameLast = TextEditingController();
  final TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton( onPressed: () => {
          Navigator.pop(context)
        }, icon: Icon(
          Icons.arrow_back, color: Colors.amber ,
        ),),
        title: Text('Name Change',style: TextStyle(
          fontSize: 22, color: Colors.amber
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.person,color: Colors.amber,size: 35,),
                  Expanded(child: TextField(
                    controller: _nameFirst,
                    style: TextStyle(color: Colors.amber),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: Text('Name',style: TextStyle(
                        color: Colors.amber,
                        fontSize: 18,),),),)),
                ],
              ),
               SizedBox(height: 20,),

              SizedBox(height: 50,),
              ElevatedButton(
                  onPressed: () => {
                    Navigator.pop(context)
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                      fixedSize: Size(330, 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.amber)
                      )

                  ),

                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Save Changes' , style: TextStyle(color: Colors.amber , fontSize: 18),)
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
