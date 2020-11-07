import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black54,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Badge(
            position: BadgePosition.bottomRight(),
            badgeContent: GestureDetector(
              onTap: getImage,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 30,
              ),
            ),
            child: Hero(
              tag: "ProfPic",
              child: CircleAvatar(
                radius: 80,
                backgroundImage: _image == null
                    ? AssetImage("images/user.png")
                    : FileImage(_image),
              ),
            ),
            padding: EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }
}
