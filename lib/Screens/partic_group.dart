import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:satta_chat/info.dart';
import 'chatting_screen.dart';

class Participants extends StatefulWidget {
  const Participants({Key? key}) : super(key: key);

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: 
            _isSearching ? _buildSearchAppBar() : _buildNormalAppBar(),

       body: Padding(
         padding: const EdgeInsets.only(top: 5.0),
         child: ListView.builder(
           shrinkWrap: true,
           itemCount: info.length,
           itemBuilder: (context, index) {
             return Column(
               children: [
                 InkWell(
                   child: Padding(
                     padding: const EdgeInsets.only(bottom: 8.0),
                     child: ListTile(
                       title: Text(
                         info[index]['name'].toString(),
                         style: const TextStyle(
                           fontSize: 18,
                         ),
                       ),

                       leading: CircleAvatar(
                         backgroundImage: NetworkImage(
                           info[index]['profilePic'].toString(),
                         ),
                         radius: 30,
                       ),

                     ),
                   ),
                 ),
                 //const Divider(color: Colors.grey, indent: 85),
               ],
             );
           },
         ),
       ),
    ),
    );
  }
  PreferredSizeWidget _buildNormalAppBar() {
    return AppBar(
      leading: IconButton(onPressed: () => {
        Navigator.pop(context)
      }, icon: Icon(Icons.arrow_back, color: Colors.amber,)),
      backgroundColor: Colors.black,
      title: Text('',style: TextStyle(
      ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 130.0,),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_add, color: Colors.amber,
                  ),
                  SizedBox(width: 5,),
                  Text('NEW GROUP' , style: TextStyle(color: Colors.amber , fontSize: 18),),

                ],
              ),
              SizedBox(width: 10,),
              Text('Add Participants', style: TextStyle(color: Colors.white , fontSize: 18 ),),
            ],
          ),
        ),
        IconButton(onPressed: (){
          setState(() {
            _isSearching= true;
          });

        }, icon: Icon(Icons.search,color: Colors.amber,))

      ],

    );

  }
  PreferredSizeWidget _buildSearchAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            _isSearching = false;
          });
        },
      ),
      title: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          // Perform search operation
        },
      ),
    );
  }

}
