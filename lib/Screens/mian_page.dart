import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satta_chat/Screens/home_ui.dart';
import 'package:satta_chat/Screens/profile_ui.dart';
import 'package:satta_chat/widgets/contact_list_tile.dart';
import 'package:satta_chat/widgets/group_list_tile.dart';


class MainPage extends StatefulWidget {
  final String image;
  final String name;
  final String data;
  const MainPage({super.key, required this.image, required this.name, required this.data});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child:
        Scaffold(
            appBar: _isSearching ? _buildSearchAppBar() : _buildNormalAppBar(),


            body: TabBarView(
              children: [
                ContactTile(data: '',),
                GroupList(),

              ],
            )
        )
    );
  }

//here class of search
  PreferredSizeWidget _buildNormalAppBar() {
    return
      AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back , color: Colors.amber,)),
        backgroundColor: Colors.black,
        title:  Text("JG",
          style: TextStyle(
              color: Colors.amber,
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  border: Border.all(
                      color: Colors.amber
                  )

              ),
              child: IconButton(

                icon: const Icon(
                  Icons.home,
                  color: Colors.amber,
                  size: 20,
                ),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeUi()) );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  border: Border.all(
                      color: Colors.amber
                  )

              ),
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_active,
                  color: Colors.amber,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  border: Border.all(
                      color: Colors.amber
                  )

              ),
              child: IconButton(
                  icon: const Icon(
                    Icons.search_outlined,
                    color: Colors.amber,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });

                  }
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  border: Border.all(
                      color: Colors.amber
                  )

              ),
              child: IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.amber,
                  size: 20,
                ),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileUi(image: widget.image, name: widget.name, data: widget.data,)) );
                },
              ),
            ),
          ),
        ],
        bottom: TabBar(
          indicatorColor: Colors.amber,
          indicatorWeight: 10,
          labelColor: Colors.amber,

          unselectedLabelColor: Colors.grey,


          labelStyle: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),
          tabs: [
            Tab(text: 'CHATS' , ),
            Tab(text: 'GROUP'),


          ],),

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