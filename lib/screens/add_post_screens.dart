import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/provider/user_provider.dart';
import 'package:instagram_app/resources/firestore_method.dart';
import 'package:instagram_app/utils/colors.dart';
import 'package:instagram_app/utils/utils.dart';
import 'dart:typed_data';
import 'package:instagram_app/models/user.dart'  as models;

import 'package:provider/provider.dart';

class AddPostScreens extends StatefulWidget {
  const AddPostScreens({super.key});

  @override
  State<AddPostScreens> createState() => _AddPostScreensState();
}

class _AddPostScreensState extends State<AddPostScreens> {
  Uint8List? _file;

  final TextEditingController _descrptionController = TextEditingController();

bool  _isloading =false ;
  void postImage(
  String uid,
  String username,
  String profImage,
      )async{
    try {
String res= await FirestoreMethod().uploade(_descrptionController.text, _file!, uid, username, profImage);
if(res =="success"){
  showSnakbar("Posted!", context);
}
    }catch(e){
      showSnakbar(e.toString(), context);

    }

  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create a Post"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Choose from Gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("cancel"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  // Uint8List file = await pickImage(ImageSource.gallery);
                  // setState(() {
                  //   _file = file;
                  // });
                },
              )
            ],
          );
        });
  }
  @override
  void dispose() {
    _descrptionController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final models.User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
            icon: Icon(Icons.upload),
            onPressed: () => _selectImage(context),
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
              ),
              title: Text("Post to"),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: ()=>postImage(user.uid, user.username,user. photoUrl),
                    child: Text(
                      "Post",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        backgroundImage:
                            NetworkImage(user.photoUrl.toString())),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .45,
                      child: TextField(
                        controller: _descrptionController,
                        decoration: InputDecoration(
                            hintText: "Write a caption...",
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(_file!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter),
                          ),
                        ),
                      ),
                    ),
                    Divider()
                  ],
                )
              ],
            ),
          );
  }
}
