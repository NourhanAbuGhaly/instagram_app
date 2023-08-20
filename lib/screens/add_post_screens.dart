import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/utils/colors.dart';
import 'package:instagram_app/utils/utils.dart';
import 'dart:typed_data';

class AddPostScreens extends StatefulWidget {
  const AddPostScreens({super.key});

  @override
  State<AddPostScreens> createState() => _AddPostScreensState();
}

class _AddPostScreensState extends State<AddPostScreens> {
  Uint8List? _file;

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
              ),  SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Choose from Gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return  _file == null ?
     Center(
        child: IconButton(
      icon: Icon(Icons.upload),
      onPressed: ()=> _selectImage(context),
    )):
     Scaffold(
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
              onPressed: () {},
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
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1682687220499-d9c06b872eee?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Write a caption...", border: InputBorder.none),
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
                          image: NetworkImage(
                              "https://plus.unsplash.com/premium_photo-1692392181683-77be581a5aaf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80"),
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
