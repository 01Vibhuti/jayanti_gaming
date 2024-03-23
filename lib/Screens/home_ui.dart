import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key}) : super(key: key);

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('HOME UI', style: TextStyle(fontSize: 50,color: Colors.amber),
        ),
        actions: [
          IconButton(onPressed:(){
            showSearch(context: context, delegate: MySearchDelegate());
          } , icon: Icon(
            Icons.search,color: Colors.amber,
          ))
        ],
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) =>
      [
        IconButton(onPressed: () {
          if(query.isEmpty){
            close(context, null);
          }
          else{
            query='';
          }
        }, icon: Icon(
          Icons.clear),)
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {}, icon: Icon(
    Icons.arrow_back),);

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [
      'Rivaan Ranawat',
    ];
    return ListView.builder(
      itemCount : suggestions.length,
     itemBuilder: (context, index){
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: (){

          },
        )
     });
  }
}
