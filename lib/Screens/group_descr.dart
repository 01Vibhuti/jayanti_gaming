import 'package:flutter/material.dart';
import 'package:satta_chat/Screens/group_icon.dart';

class GroupDes extends StatefulWidget {
  final String name;
  final String image;

  const GroupDes({Key? key, required this.name, required this.image}) : super(key: key);

  @override
  State<GroupDes> createState() => _GroupDesState();
}

class _GroupDesState extends State<GroupDes> {
  TextEditingController _saveDescription = TextEditingController();
  String _saveText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Group Description',style: TextStyle(color: Colors.amber),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _saveDescription,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Add group description',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16),
            child: Text('The group description is visible to members of this group and people invited to this group.'),
          ),
          Container(
            width: 390,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);

                }, child: Text('Cancel',style: TextStyle(color: Colors.amber),)),

                ElevatedButton(onPressed: () {
                  setState(() {
                    _saveText = _saveDescription.text;
                  });
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GroupIcon(image: widget.image, name:widget.name, data: _saveText,)));

                }, child: Text('Ok',style: TextStyle(color: Colors.amber,
                ),)),


              ],
            ),
          ),
        ],
      )


    );


  }
}
