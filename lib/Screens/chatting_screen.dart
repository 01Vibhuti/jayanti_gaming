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
  File? _pickedImage;
  String filePath = "";
  bool emojiShowing = false;


  List<ChatMessage> messages = [];
  final TextEditingController _textEditingController = TextEditingController();

  void _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true);

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
                TextButton(onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ProfileUi(image: widget.image,
                                name: widget.name,
                                data: widget.data))),
                  child: Text(widget.name, style: TextStyle(color: Colors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),),
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
                      title: Text(
                          'Name Change', style: TextStyle(color: Colors.amber)),
                      onTap: () =>
                      {
                        setState(() {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>
                                  NameChange()
                              ));
                        },


                        ),

                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      title: Text(
                          'Chat Delete', style: TextStyle(color: Colors.amber)),
                      onTap: () {
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: Text('Delete this chat?'),
                            content: Text('des'),
                            actions: <Widget>[
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
                      title: Text(
                          'Block', style: TextStyle(color: Colors.amber)),
                      onTap: () {
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: Text('Block'),
                            content: Text('des'),
                            actions: <Widget>[
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
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
                      padding: const EdgeInsets.only(right: 100.0, left: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onLongPress: () {
                            showDialog(context: context, builder: (context) {
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
                                    Clipboard.setData(
                                        ClipboardData(text: message.text));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
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
                                    child: Text('Remove'),
                                  ),

                                ],
                              );
                            });
                          },
                          child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.5, // Max width 50% of screen
                                minWidth: 0, // Allow minimum width
                              ),
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.amber),
                                borderRadius: BorderRadius.circular(8),
                              ),

                              child: Text(message.text, style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),)),
                        ),),
                    );
                  },
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0)),
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
                            icon: Icon(
                                Icons.attach_file_sharp, color: Colors.amber),
                          ),
                          Expanded(
                            child:
                            TextField(
                              controller: _textEditingController,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              // Allows multiple lines
                              decoration: InputDecoration(
                                hintText: 'Text Now...',
                                labelStyle: TextStyle(color: Colors.white),
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 17),
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
                          SizedBox(width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.1),
                          IconButton(
                            onPressed: (){_showBottomSheet(context);},
                            icon: Icon(
                                Icons.camera_alt_sharp, color: Colors.amber),
                          ),
                          IconButton(onPressed: () {}, icon: Icon(
                              Icons.mic, color: Colors.amber)),
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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builderContext) {
        return SingleChildScrollView(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: Container(
              color: Colors.white,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Pic Image From",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text("CAMERA"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("GALLERY"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      label: const Text("CANCEL"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        _pickedImage = tempImage;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}


class ChatMessage {
  final String text;
  final File? file;

  ChatMessage({required this.text, this.file});
}
