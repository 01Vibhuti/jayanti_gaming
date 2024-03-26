import 'package:flutter/material.dart';
class EmojisWidget extends StatefulWidget {
  final Function addEmojiToTextController;
   EmojisWidget({
    super.key,
     required this.addEmojiToTextController,
});


  State<EmojisWidget> createState() => _EmojisWidgetState();
}

class _EmojisWidgetState extends State<EmojisWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}
