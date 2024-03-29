import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:satta_chat/Screens/name_change.dart';
import 'package:satta_chat/Screens/profile_ui.dart';

class ChattingScreen extends StatefulWidget {
  ChattingScreen({Key? key, required this.name, required this.image, required this.data}) : super(key: key);

  final String name;
  final String image;
  final String data;


  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  File? selectedImage;
  String filePath = "";
  bool emojiShowing = false;



  List<ChatMessage> messages = [];
  final TextEditingController _textEditingController = TextEditingController();

  void _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      for (var file in files) {
        messages.add(ChatMessage(text: '', file: file));
      }
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  void _sendMessage() {
    String messageText = _textEditingController.text.trim();
    if (messageText.isNotEmpty) {
      messages.insert(0, ChatMessage(text: messageText));
      _textEditingController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.arrow_back, color: Colors.amber),
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.0,
                  backgroundImage: NetworkImage(widget.image),
                ),
                SizedBox(width: 5),
                TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProfileUi(image: widget.image, name: widget.name, data: widget.data) )),
                  child:Text(widget.name, style: TextStyle(color: Colors.amber , fontSize: 20 , fontWeight: FontWeight.bold ),),
                ),
              ],
            ),
          ),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.amber, size: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.amber),
              ),
              color: Colors.black54,
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    child: ListTile(
                      title: Text('Name Change', style: TextStyle(color: Colors.amber)),
                      onTap: () => {
                        setState((){
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                              NameChange()
                          ));

                        },


                        ),

                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      title: Text('Chat Delete', style: TextStyle(color: Colors.amber)),
                      onTap: () {
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text('Delete this chat?'),
                            content: Text('des'),
                            actions: <Widget> [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Cancel')),
                              TextButton(onPressed: () {
                                setState(() {
                                  messages.clear();
                                });
                                Navigator.of(context).pop();

                              }, child: Text('ok'),

                                     ),

                            ],
                          );
                        });
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      title: Text('Block', style: TextStyle(color: Colors.amber)),
                      onTap: () {
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text('Block'),
                            content: Text('des'),
                            actions: <Widget> [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Cancel')),
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Block')),

                            ],
                          );
                        });
                      },
                    ),
                  ),
                ];
              },
            )
          ],
          elevation: 10,
        ),
        body:
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.blueGrey,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true, // Reverse the list
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 100.0,left: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onLongPress: (){
                            showDialog(context: context, builder: (context){
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                title: Text(''),
                                content: Text('Perform Action?',
                                style: TextStyle(
                                  color: Colors.amber
                                ),),
                                actions: <Widget>[
                                  TextButton(onPressed: () {
                                    Navigator.pop(context);
                                    Clipboard.setData(ClipboardData(text: message.text));
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Message copied'),

                                    ));

                                  }, child: Text('copy')),
                                  TextButton(
                                    onPressed: () {

                                      setState(() {
                                        messages.removeAt(index);
                                      });
                                      Navigator.of(context).pop();
                                       // Close the AlertDialog
                                    },
                                    child: Text('OK'),
                                  ),

                                ],
                              );
                            });
                          },
                          child: Container(
                             //height: MediaQuery.of(context).size.height*0.055,
                              width:20,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.amber),
                                borderRadius: BorderRadius.circular(8),

                              ),
                              child: Row(
                                children: [
                                  Text
                                    (message.text,  style: TextStyle(fontSize: 17 , color: Colors.white,fontWeight: FontWeight.bold),),


                                ],
                              )),
                        ),                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(

                      child: Row(
                        children: [
                          //if(emojiShowing)
                            //EmojisWidget(addEmojiToTextController: addEmojiToTextController),
                          IconButton(
                            onPressed: _pickDocument,
                            icon: Icon(Icons.attach_file_sharp, color: Colors.amber),
                          ),
                          Expanded(
                            child:
                            TextField(
                              controller: _textEditingController,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.multiline,
                              maxLines: null, // Allows multiple lines
                              decoration: InputDecoration(
                                hintText: 'Text Now...',
                                labelStyle: TextStyle(color: Colors.white),
                                hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                          IconButton(
                            onPressed:imagePickerCamera,
                            icon: Icon(Icons.camera_alt_sharp, color: Colors.amber),
                          ),
                          IconButton(onPressed: (){}, icon: Icon(Icons.mic, color: Colors.amber)),
                          IconButton(
                            onPressed: _sendMessage,
                            icon: Icon(Icons.send, color: Colors.amber),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future imagePickerCamera()async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        sourcePath: returnedImage!.path
    );
    if(returnedImage == null)return;
    setState(() {
      selectedImage = File(croppedFile!.path);
      Navigator.of(context).pop();

    });
  }
  // Widget showEmojiPicker() {
  //   return EmojiPicker(
  //
  //     onEmojiSelected: (category, emoji){
  //       print(emoji);
  //     });

  // addEmojiToTextController({required Emoji emoji}) {
  //
  // }
}



class ChatMessage {
  final String text;
  final File? file;

  ChatMessage({required this.text, this.file});
}
