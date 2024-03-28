import 'package:flutter/material.dart';
import 'package:satta_chat/Screens/group_chatscreen.dart';
import 'package:satta_chat/Screens/partic_group.dart';
import 'package:satta_chat/group_info.dart';
import 'package:satta_chat/info.dart';

import '../Screens/chatting_screen.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(height: 5,),
        ElevatedButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Participants()) );
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
                Icon(Icons.group , color: Colors.amber,),
                SizedBox(width: 5,),
                Text('NEW GROUP' , style: TextStyle(color: Colors.amber , fontSize: 18),)
              ],
            )
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: groupinfo.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              GroupChattingScreen(
                                image: info[index]['profilePic'].toString(),
                                name: groupinfo[index]['name'].toString(),),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(
                          groupinfo[index]['name'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            groupinfo[index]['message'].toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            groupinfo[index]['profilePic'].toString(),
                          ),
                          radius: 30,
                        ),
                        trailing: Text(
                          groupinfo[index]['time'].toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(color: Colors.grey, indent: 85),
                ],
              );
            },
          ),
        ),

      ],
    );
  }
}
